//
//  API_Maneger.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 16/06/21.
//


import Foundation
import Alamofire

typealias JSON = [String: Any]

class APIManager {
  
  public static var handleSessionExpired: (() -> Void)?
  
  public static func request(method: HTTPMethod,
                             parameters: [String:Any]?,
                             url: String,
                             header: [String:String]? = nil,
                             cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad,
                             completion: @escaping (ServiceResponse<Any>) -> Void)
                              {
    

          makeRequest(method: method, parameters: parameters,url: url,completion: completion,header: header)
        }
  
  
  private static func makeRequest(method: HTTPMethod,
                          parameters: [String:Any]?,
                          url: String,
                          completion: @escaping (ServiceResponse<Any>) -> Void,
                          header: [String:String]? = nil
                          ) {
    var headers = header ?? [:]
    
    let request = self.getRequest(url, method, parameters, nil, headers)
    
    request?.responseJSON(completionHandler: { response in
      
      print("\nResponse:")
        switch response.result {
        case .success(let data):
          print("RESULT (Success) -> \(convertToString(response.result.value))")
          if let responseJson = data as? [String: Any] {
            completion(.success(responseJson))
          } else if let dataJson = jsonToNSData(json: data as AnyObject),
            let json = (try? JSONSerialization.jsonObject(with: dataJson, options: JSONSerialization.ReadingOptions(rawValue: 0))) as? [[String : AnyObject]] {
            completion(.success(json))
          } else {
            completion(.failure(ServiceError.wrongJson))
          }
          
        case .failure(let error):
          print("RESULT (Failure) -> \(convertToString(error.json()))")
          let errorDictionary = error.json()
          if let code = errorDictionary["code"] as? Int,
            code == 4 {
            completion(.failure(ServiceError.emptyData))
          } else if error._code == NSURLErrorTimedOut {
              print("Request timeout!")
            completion(.failure(ServiceError.timeout))
          } else {
            completion(.failure(ServiceError.failure))
          }
        }
    })
  }
  
  @discardableResult
  private static func getRequest(_ link: String,
                                 _ method: HTTPMethod,
                                 _ parameters: Any?,
                                 _ encoding: JSONEncoding? = nil,
                                 _ headers: [String:String]? = nil
                                 ) -> DataRequest? {
    
    var headerFinal: [String : String] = [:]
    if let header_ = headers { headerFinal = header_ }

    
    headerFinal.updateValue("application/json", forKey: "Content-Type")
    headerFinal.updateValue("max-age=604800", forKey: "Cache-Control") //60seconds*60minutes*24hours*7days
    
    print("--------------------------------------------")
    print("URL -> \(link)")
    print("HEADER -> \(convertToString(headerFinal))")
    print("PARAMETERS -> \(convertToString(parameters))")
    
    if let _parameters = parameters as? [String: Any] {
      if let encoding = encoding {
        return Alamofire.request(link, method: method, parameters: _parameters, encoding: encoding, headers: headerFinal)
      } else {
        guard let url = URL(string: link) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headerFinal
        request.timeoutInterval = 35
        guard let httpBody = try? JSONSerialization.data(withJSONObject: _parameters) else { return nil }
        request.httpBody = httpBody
        
        return Alamofire.request(request)
      }
    } else {
      guard let url = URL(string: link) else { return nil }
      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue
      request.allHTTPHeaderFields = headerFinal
      request.timeoutInterval = 35
      return Alamofire.request(request)
    }
  }
  
}

//-----------------------------------------------------------------------------------------------------------------------------

public func jsonToNSData(json: AnyObject) -> Data? {
  do {
    return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
  } catch let myJSONError {
    print(myJSONError)
  }
  return nil
}

public func convertToString(_ obj: Any?) -> String {
  if let collection = obj as? Array<AnyObject> {
    return collection.json()
  }
  if let collection = obj as? Dictionary<AnyHashable, AnyObject> {
    return collection.json()
  }
  return "\(obj ?? "nil")"
}

public extension Collection {
  func json() -> String {
    guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
      let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
        return "{\n}"
    }
    return jsonString.replacingOccurrences(of: "\\/", with: "/")
  }
}

public extension Error {
  func json() -> [String: Any] {
    return (self as NSError).json()
  }
}

public extension NSError {
  func json() -> [String: Any] {
    return [
      "code": self.code,
      "description": self.localizedDescription
    ]
  }
}

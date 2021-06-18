//
//  Dictionary.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 16/06/21.
//

import Foundation

public extension Dictionary {
  
  func toString() -> String? {
    do {
      let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
      return String(data: data, encoding: String.Encoding.utf8) ?? nil
    } catch {
      return nil
    }
  }
  
  func decode<T>(_ type: T.Type) -> T? where T : Decodable {
    if let jsonString = self.toString(),
      let jsonData = jsonString.data(using: .utf8),
      let objc = try? JSONDecoder().decode(type, from: jsonData) {
      return objc
    }
    return nil
  }
  
}

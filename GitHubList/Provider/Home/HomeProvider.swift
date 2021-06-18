//
//  HomeProvider.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 16/06/21.
//

import Foundation

//Oque seria este @escaping
//R:response result da retrofit

protocol HomeProviderDelegate {
    func getRepositoriosInfo(successCallBack: @escaping (Welcome) -> Void, errorCallBack: @escaping (Error) -> Void)
}
//Como este delegate se difere dos demais ?, da view Model e da cell.
//Os Protocols sao tipo interfaces ? -> Sao como se fosse interfaces, pesquisar sobre a diferença.
class HomeProvider : HomeProviderDelegate {
    
    func getRepositoriosInfo(successCallBack: @escaping (Welcome) -> Void, errorCallBack: @escaping (Error) -> Void) {
        
        let url = EndPoints.home.rawValue
        
        
        APIManager.request(method: .get, parameters: nil, url: url) { (response) in
          switch response {
          case .success(let data):
            if let json = data as? JSON,
              let model = json.decode(Welcome.self) {
              successCallBack(model)
            } else {
              errorCallBack(ServiceError.parsing)
            }
          case .failure(let error):
            print(error)
            errorCallBack(ServiceError.failure)
          }
        }
  
    }
    
}

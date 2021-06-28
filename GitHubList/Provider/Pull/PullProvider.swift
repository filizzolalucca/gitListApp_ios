//
//  PullProvider.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 18/06/21.
//

import Foundation

//Provider sao classes responsaveis por realizar chamadas de API

protocol PullProviderDelegate {
    func getRepositoriosInfo(userName:String,repoName:String,successCallBack: @escaping ([PullModel]) -> Void, errorCallBack: @escaping (Error) -> Void)
}
class PullProvider:PullProviderDelegate{
    func getRepositoriosInfo(userName:String,repoName:String,successCallBack: @escaping ([PullModel]) -> Void, errorCallBack: @escaping (Error) -> Void) {
        
        let url = EndPoints.pullrequests.rawValue.replacingOccurrences(of: "{user}", with: userName)
            .replacingOccurrences(of:"{repo}" , with: repoName)
        
        
        APIManager.request(method: .get, parameters: nil, url: url) { (response) in
            switch response {
            //Quando O json retorna apenas uma lista de elementos a conversao é feita dessa forma
            case .success(let data):
                let jsonData = try? JSONSerialization.data(withJSONObject: data)
                
                do {
                    
                    let model = try JSONDecoder().decode([PullModel].self, from: jsonData!)
                    
                    successCallBack(model)
                    
                } catch {
                    
                    errorCallBack(ServiceError.parsing)
                    
                }

            case .failure(let error):
                print(error)
                errorCallBack(ServiceError.failure)
            }
        }
        
    }
}

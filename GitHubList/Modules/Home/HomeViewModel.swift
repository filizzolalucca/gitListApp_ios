//
//  HomeViewModel.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 17/06/21.
//

import Foundation
import Resolver

//A ViewModel é responsavel por criar e disparar o delegate. Enquanto a viewController que esta assinada como o seu delegate ira realizar alguma acao por conta desse desparo


protocol HomeViewModelDelegate: NSObject{
    func successReponse()
    func errorResponse()
}
class HomeViewModel{
    
    //MARK: - public properties
    
    weak var delagate: HomeViewModelDelegate?
    let provider: HomeProviderDelegate = Resolver.resolve()
    var data: Welcome?
    var repoList: [Item] = []
    var numberOfRepositorios: Int = 0
    
    //MARK: -class method
    private func refresehContent(data:Welcome){
        self.data=data
        self.repoList = data.items
        self.numberOfRepositorios = repoList.count

    }
    
   
    
    
    func fechData(){
        self.provider.getRepositoriosInfo(successCallBack: {[weak self] (data) in
            self?.refresehContent(data: data)
            self?.delagate?.successReponse()
        }, errorCallBack:
            {[weak self](error) in
                self?.delagate?.errorResponse()
            print("deu erro na requisicao")
        })
    }
    
    
    
    
}

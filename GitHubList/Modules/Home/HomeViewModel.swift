//
//  HomeViewModel.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 17/06/21.
//

import Foundation

//A ViewModel é responsavel por criar e disparar o delegate. Enquanto a viewController que esta assinada como o seu delegate ira realizar alguma acao por conta desse desparo


protocol HomeViewModelDelegate: NSObject{
    func successReponse()
    func errorResponse()
}
class HomeViewModel{
    
    //MARK: - public properties
    
    // se eu perder a referencia dessa delegate, nao vai dar erro  por causa da weak
    weak var delagate: HomeViewModelDelegate?
    let provider: HomeProviderDelegate
    var data: Welcome?
    var repoList: [Item] = []
    var numberOfRepositorios: Int = 0
    
    //MARK: - initial init
    init(provider: HomeProviderDelegate) {
        self.provider = provider
    }
    
    //MARK: -class method
    private func refresehContent(data:Welcome){
        self.data=data
        self.repoList = data.items
        self.numberOfRepositorios = repoList.count
    
    }
    
    //MARK: - Public methods(Aonde vai disparar o delegate)
    
    
    //Eu nao sei se eu vou perder ou nao a referencia, por isso o weak self
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

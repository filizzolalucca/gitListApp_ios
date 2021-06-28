//
//  PullViewModel.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 18/06/21.
//

import Foundation


protocol PullViewModelDelegate : NSObject{
    func successResponse()
    func errorResponse()
}

class PullViewModel{
    
    
    //MARK: - Public proprietes
    weak var delagate:PullViewModelDelegate?
    let provider:PullProviderDelegate
    var data:[PullModel]?
    var pullList:[PullModel]=[]
    var numberOfPRs:Int = 0
    
    //MARK: - init method
    init(provider:PullProviderDelegate) {
        self.provider = provider
    }
    
    //MARK: - Class methods
    private func refreshContent(data:[PullModel]){
        self.data = data
        self.pullList = data
        self.numberOfPRs = pullList.count
    }
    
    //MARK: - Public methods
    
    func fechData(userName:String,repoName:String){
        self.provider.getRepositoriosInfo(userName: userName, repoName: repoName, successCallBack:{
            [weak self] (data) in self?.refreshContent(data: data)
            self?.delagate?.successResponse()
        }
        , errorCallBack:{
            [weak self] (error) in
            self?.delagate?.errorResponse()
            print("deu erro na requisicao")
        })
    }
    
    
    
    
}

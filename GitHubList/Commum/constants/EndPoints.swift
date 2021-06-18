//
//  EndPoints.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 16/06/21.
//

import Foundation


enum EndPoints{
    case home
    case pullrequests
    
    internal var schema: String{
        #if DEBUG
        return "https://api.github.com"
        #else
        return "https://api.githu.com"
        #endif
    }
    //Estes parametros a gente passa como ? -> por replace
    
    private enum Key{
        static let home = "/search/repositories?q=language:Java&sort=stars&page=1"
        static let pullrequests = "/repos/{user}/{repo}/pulls"
    }
    
    
    var rawValue: String{
        switch self {
        case .home:
            return "\(self.schema)\(Key.home)"
        case .pullrequests:
        return "\(self.schema)\(Key.pullrequests)"
    }
}

}

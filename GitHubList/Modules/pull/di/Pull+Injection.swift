//
//  Pull+Injection.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 10/09/21.
//

import Foundation


import  Resolver

extension Resolver{
    public static func registerMyPullServices(){
        register{PullViewModel()}
        register{PullProvider() as PullProviderDelegate}
    }
}


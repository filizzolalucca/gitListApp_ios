//
//  Home+Injection.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 10/09/21.
//

import  Resolver

extension Resolver{
    public static func registeryMyHomeServices(){
        register{HomeViewModel()}
        register{HomeProvider() as HomeProviderDelegate}
    }
}

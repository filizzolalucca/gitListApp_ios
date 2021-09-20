//
//  AppDelegate+Injection.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 10/09/21.
//

import Resolver


extension Resolver : ResolverRegistering {
    public static func registerAllServices() {
        registeryMyHomeServices()
        registerMyPullServices()
    }
    
    

    
    
    
}

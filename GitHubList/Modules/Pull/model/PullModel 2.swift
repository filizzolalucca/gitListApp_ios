//
//  PullModel.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 16/06/21.
//

import Foundation


struct PullModel:Codable {
    let title:String
    let body:String
    let user:User
    
}

struct User: Codable{
    let username:String
    let imageurl:String
    
    enum CodingKeys:String,CodingKey {
        case username = "login"
        case imageurl = "avatar_url"
    }
}

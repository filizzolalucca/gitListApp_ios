////
////  Welcome.swift
////  GitHubList
////
////  Created by Lucca Filizzola on 15/06/21.
////
//
import Foundation

struct Welcome: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name:String?
    let description:String?
    let fullName: String?
    let owner: Owner?
    let numForks:Int64?
    let starNumber:Int64?

    enum CodingKeys:String, CodingKey{
    case name
    case description
    case fullName
    case owner
    case numForks = "forks"
    case starNumber = "stargazers_count"
    }
}

struct Owner: Codable{
    let login: String?
    let imageURL:String?
    
    enum CodingKeys:String, CodingKey{
    case login
    case imageURL = "avatar_url"
    }
    
}

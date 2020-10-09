//
//  Repository.swift
//  BestSwiftRepositories
//
//  Created by Lucas Cesar on 06/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import UIKit
import Foundation

struct Repositories: Codable {
    
    let incompleteResults : Bool?
    let items : [Repository]
    let totalCount : Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case incompleteResults = "incomplete_results"
        case totalCount = "total_count"
    }
}

struct Repository: Codable {
    
    let name: String
    let stars: Int
    let description: String?
    let owner: RepositoriesOwners
    
    enum CodingKeys: String, CodingKey {
        case name, owner, description
        case stars = "stargazers_count"
    }
}

struct RepositoriesOwners: Codable {
    
    let ownerImage, ownerName: String
    
    enum CodingKeys: String, CodingKey {
        case ownerImage = "avatar_url"
        case ownerName = "login"
    }
}

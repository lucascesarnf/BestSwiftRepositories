//
//  Repository+Equatable.swift
//  BestSwiftRepositoriesTests
//
//  Created by Lucas Cesar on 07/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import Foundation
@testable import BestSwiftRepositories


extension Repository: Equatable {
    public static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.description == rhs.description &&
        lhs.name == rhs.name &&
        lhs.stars == rhs.stars &&
        lhs.owner == rhs.owner
    }
}

extension RepositoriesOwners: Equatable {
    public static func == (lhs: RepositoriesOwners, rhs: RepositoriesOwners) -> Bool {
        return lhs.ownerImage == rhs.ownerImage &&
        lhs.ownerName == rhs.ownerName
    }
}

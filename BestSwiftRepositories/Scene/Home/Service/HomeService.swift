//
//  HomeService.swift
//  BestSwiftRepositories
//
//  Created by Lucas Cesar on 06/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import Foundation

enum HomeService {
    case bestRepo(page: Int, reposPerPage: Int)
}

extension HomeService: Service {
    
    var path: String {
        switch self {
        case .bestRepo:
             return "/search/repositories"
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .bestRepo(let page, let reposPerPage):
            return [
                "q" : "language:swift",
                "sort" : "stars",
                "page" : "\(page)",
                "per_page" : "\(reposPerPage)"
            ]
        }
    }

    var method: ServiceMethod {
        return .get
    }
}

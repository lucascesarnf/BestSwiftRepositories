//
//  Service.swift
//  ChuckNorrisFacts
//
//  Created by Lucas César  Nogueira Fonseca on 24/10/19.
//  Copyright © 2019 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation
import UIKit

enum Timeout: Double {
    case normal = 30
    case extended = 60
}

enum ServiceMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Stubs {
    case stub(fileName: String)
    case fail
}

enum ServiceState {
    case request
    case response(Result<Data, Error>)
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: ServiceMethod { get }
    var timeout: Timeout { get }
}

extension Service {
    var baseURL: String {
        return "https://api.github.com/search/repositories"
    }
    
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            return URLRequest(url: NSURL() as URL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    public var urlString: String {
        return "\(urlRequest)"
    }
    
    public var timeout: Timeout {
        return .normal
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        if case .get = method {
            if let parameters = parameters as? [String: String] {
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
        }
        return urlComponents?.url
    }
}

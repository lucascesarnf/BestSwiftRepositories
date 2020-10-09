//
//  URLRequest+Log.swift
//  ChuckNorrisFacts
//
//  Created by Lucas César  Nogueira Fonseca on 06/10/20.
//  Copyright © 2020 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

extension URLRequest {
    
    func log() {
        print("\(httpMethod ?? "") \(self)")
        print("BODY \n \(String(describing: httpBody?.toString()))")
        print("HEADERS \n \(String(describing: allHTTPHeaderFields))")
    }
}

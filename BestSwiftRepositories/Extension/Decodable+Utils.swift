//
//  Decodable+Utils.swift
//  ChuckNorrisFacts
//
//  Created by Lucas César  Nogueira Fonseca on 06/10/20.
//  Copyright © 2020 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

extension Decodable {
    
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}

//
//  Data+String.swift
//  ChuckNorrisFacts
//
//  Created by Lucas César  Nogueira Fonseca on 06/10/20.
//  Copyright © 2020 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

extension Data {
    
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

//
//  ServiceExecutor.swift
//  ChuckNorrisFacts
//
//  Created by Lucas César  Nogueira Fonseca on 06/10/20.
//  Copyright © 2020 Lucas César  Nogueira Fonseca. All rights reserved.
//

import Foundation

protocol ServiceExecutor: AnyObject {
    func execute<T: Service>(_ service: T, completion: @escaping (Result<Data, Error>) -> Void)
}

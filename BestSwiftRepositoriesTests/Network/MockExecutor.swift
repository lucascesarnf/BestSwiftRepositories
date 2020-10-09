//
//  MockExecutor.swift
//  BestSwiftRepositoriesTests
//
//  Created by Lucas Cesar on 07/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import Foundation
@testable import BestSwiftRepositories

class MockExecutor: ServiceExecutor {
    
    private var shouldSave = true
    
    var jsonFile: String?
    
    func execute<T: Service>(_ service: T, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let jsonFile = self.jsonFile else {
            DispatchQueue.global(qos: .background).async {
                completion(.failure(CustomError.generic))
            }
            return
        }
        
        if let data = Self.getDataFromJson(jsonFile: jsonFile) {
            DispatchQueue.global(qos: .background).async {
                completion(.success(data))
            }
        }
    }
    
    static func getDataFromJson(jsonFile: String) -> Data? {
        let testBundle = Bundle(for: MockExecutor.self)
        guard let url = testBundle.url(forResource: jsonFile, withExtension: "json"),
            let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}

//
//  XCTestCase+ExpectedData.swift
//  BestSwiftRepositoriesTests
//
//  Created by Lucas Cesar on 07/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import Foundation
@testable import BestSwiftRepositories
import XCTest

extension XCTestCase {
    func getExpectedData<U: Decodable>(from json: String, decodeType: U.Type) -> U {
        let expectedData = MockExecutor.getDataFromJson(jsonFile: json)
        return try! decodeType.decode(from: expectedData!)
    }
}

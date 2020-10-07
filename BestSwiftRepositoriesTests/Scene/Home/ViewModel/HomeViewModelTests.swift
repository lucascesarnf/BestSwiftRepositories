//
//  HomeViewModelTests.swift
//  BestSwiftRepositoriesTests
//
//  Created by Lucas Cesar on 07/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import XCTest
@testable import BestSwiftRepositories

class HomeViewModelTests: XCTestCase {
    
    let jsonFile = "RepositoriesResponse"
    let executor = MockExecutor()
    lazy var provider = ServiceProvider<HomeService>(executor: executor)
    lazy var viewModel = HomeViewModel(provider: provider, reposPerPage: 3)
    
    func testLoadRepositoriesSuccess() {
        let expectedData = getExpectedData(from: jsonFile, decodeType: Repositories.self)
        
        let expectation = self.expectation(description: "Load repositories with Success")
        
        executor.jsonFile = jsonFile
        viewModel.loadRepositories()
        
        let sink = viewModel.$repositories.sink { repositories in
            if repositories.count > 0 {
                XCTAssertEqual(repositories.count,
                               expectedData.items.count, "The number of elements is wrong")
                XCTAssertEqual(repositories.first,
                               expectedData.items.first, "The first elements do not match")
                XCTAssertEqual(repositories.last,
                               expectedData.items.last, "The last elements do not match")
                expectation.fulfill()
            }
        }
        
        XCTAssertNotNil(sink)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadRepositoriesFailure() {
        let expectedData = CustomError.generic
        let expectation = self.expectation(description: "Load repositories with Failure")
        
        executor.jsonFile = nil
        viewModel.loadRepositories()
        
        let sink = viewModel.$currentState.sink { state in
            switch state {
            case .error(let error):
                XCTAssertEqual(error,
                               expectedData, "The expected error and the given error are different")
                expectation.fulfill()
            default : break
            }
        }
        
        XCTAssertNotNil(sink)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadTwoRepositoriesPagesSuccess() {
        let expectedData = getExpectedData(from: jsonFile, decodeType: Repositories.self)
        
        let expectation = self.expectation(description: "Load two repositories pages with Success")
        
        executor.jsonFile = jsonFile
        viewModel.loadRepositories()
        
        var numberOfPages = 0
        let sink = viewModel.$repositories.sink { repositories in
            if repositories.count > 0 {
                numberOfPages += 1
                if numberOfPages == 1 {
                    XCTAssertEqual(repositories.count,
                                   expectedData.items.count, "The number of elements is wrong")
                    XCTAssertEqual(repositories.first,
                                   expectedData.items.first, "The first elements do not match")
                    XCTAssertEqual(repositories.last,
                                   expectedData.items.last, "The last elements do not match")

                    self.viewModel.loadRepositories()
                } else if numberOfPages == 2 {
                    XCTAssertEqual(repositories.count,
                    expectedData.items.count * 2, "The number of two pages elements is wrong")
                    expectation.fulfill()
                }
            }
        }
        
        XCTAssertNotNil(sink)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResetData() {
        let expectedData = getExpectedData(from: jsonFile, decodeType: Repositories.self)
        
        let expectation = self.expectation(description: "Reset viewModel data with Success")
        
        executor.jsonFile = jsonFile
        viewModel.loadRepositories()
        
        var dataCleaned = false
        var testRepositories:[Repository] = []
        
        let repositorySink = viewModel.$repositories.sink { repositories in
            if repositories.count > 0 {
                testRepositories = repositories
                XCTAssertEqual(repositories[0],
                               expectedData.items[0], "The expected data and the given data are different")
                self.viewModel.resetData()
                dataCleaned = true
            }
        }
        XCTAssertNotNil(repositorySink)
        
        let stateSynk = viewModel.$currentState.sink { state in
            if dataCleaned {
                if case .empty = state {
                    XCTAssertEqual(testRepositories.count,
                                   expectedData.items.count, "The number of elements is wrong")
                    XCTAssertEqual(testRepositories.first,
                                   expectedData.items.first, "The first elements do not match")
                    XCTAssertEqual(testRepositories.last,
                                   expectedData.items.last, "The last elements do not match")
                    
                    dataCleaned = false
                    expectation.fulfill()
                } else {
                    XCTFail("The viewModel data was not cleaned")
                }
            }
        }
        XCTAssertNotNil(stateSynk)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

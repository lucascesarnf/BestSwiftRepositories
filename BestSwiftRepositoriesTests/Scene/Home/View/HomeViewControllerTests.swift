//
//  HomeViewControllerTests.swift
//  BestSwiftRepositoriesTests
//
//  Created by Lucas Cesar on 07/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import BestSwiftRepositories


/// ⚠️ Attention ⚠️
/// To run the snapshot tests and achieve the same results it is necessary to select the `Test Schema` and select `iPhone 8` as the device.

class HomeViewControllerTest: XCTestCase {
    
    let jsonFile = "RepositoriesResponse"
    let executor = MockExecutor()
    lazy var provider = ServiceProvider<HomeService>(executor: executor)
    lazy var viewModel = HomeViewModel(provider: provider, reposPerPage: 3)
    let strategy: Snapshotting<UIViewController, UIImage> = Snapshotting.image(
        precision: 0.90,
        size: CGSize(width: 300, height: 600)
    )
    
    func testLoadState() {
        let viewController = HomeViewController(viewModel: viewModel)
        assertSnapshot(matching: viewController, as: strategy)
    }
    
    func testRequestFirstPage() {
        let expectation = self.expectation(description: "Load first repositories page with Success")
        let viewController = HomeViewController(viewModel: viewModel)
        executor.jsonFile = jsonFile
        viewController.viewDidLoad()
        
        let sink = viewModel.$repositories.sink { repositories in
            if repositories.count > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    expectation.fulfill()
                }
            }
        }
        XCTAssertNotNil(sink)
        waitForExpectations(timeout: 3, handler: nil)
        
        assertSnapshot(matching: viewController, as: strategy)
    }
    
    func testRequestTwoPages() {
        let expectation = self.expectation(description: "Load two repositories pages with Success")
        executor.jsonFile = jsonFile
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.viewDidLoad()
        
        var numberOfPages = 0
        var lastValidation = false
        
        let sink = viewModel.$repositories.sink { repositories in
            if repositories.count > 0 && !lastValidation {
                numberOfPages += 1
                if numberOfPages == 1 {
                    assertSnapshot(matching: viewController, as: self.strategy)
                    self.viewModel.loadRepositories()
                } else if numberOfPages == 2 {
                    lastValidation = true
                    expectation.fulfill()
                }
            }
        }
        XCTAssertNotNil(sink)
        
        waitForExpectations(timeout: 3, handler: nil)
        assertSnapshot(matching: viewController, as: strategy)
    }
    
    func testResetData() {
        let expectation = self.expectation(description: "Reset viewModel data with Success")
        let viewController = HomeViewController(viewModel: viewModel)
        executor.jsonFile = jsonFile
        viewController.viewDidLoad()
        
        var dataCleaned = false
        
        var numberOfPages = 0
        var lastValidation = false
        
        let repositorySink = viewModel.$repositories.sink { repositories in
            if repositories.count > 0 && !lastValidation {
                numberOfPages += 1
                if numberOfPages == 1 {
                    assertSnapshot(matching: viewController, as: self.strategy)
                    self.viewModel.loadRepositories()
                } else if numberOfPages == 2 {
                    lastValidation = true
                    dataCleaned = true
                    assertSnapshot(matching: viewController, as: self.strategy)
                    self.viewModel.resetData()
                }
            }
        }
        
        XCTAssertNotNil(repositorySink)
        
        let stateSynk = viewModel.$currentState.sink { state in
            if dataCleaned {
                if case .empty = state {
                    dataCleaned = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        expectation.fulfill()
                    }
                }
            }
        }
        
        XCTAssertNotNil(stateSynk)
        
        waitForExpectations(timeout: 3, handler: nil)
        assertSnapshot(matching: viewController, as: strategy)
    }
    
    /// TEST INCOMPLETE
    /// The solution suggestion given by the team that developed the framework is not working as expected
    /// https://github.com/pointfreeco/swift-snapshot-testing/issues/279
    /// In order to present a modal view controller, its parent view controller must already be a member of a window hierarchy. Therefore given that SnapshotTesting prepares its window internally, there's no way to correctly present the modal controller.
    func testErrorAlert() {
        let expectation = self.expectation(description: "Load repositories with Error")
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewModel.loadRepositories()
        
        let sink = viewModel.$currentState.sink { state in
            if case .error = state {
                    expectation.fulfill()
            }
        }
        XCTAssertNotNil(sink)
        waitForExpectations(timeout: 3, handler: nil)
        assertSnapshot(matching: viewController, as: .windowedImage)
    }
}

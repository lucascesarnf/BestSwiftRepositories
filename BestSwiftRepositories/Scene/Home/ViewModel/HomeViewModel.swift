//
//  HomeViewModel.swift
//  BestSwiftRepositories
//
//  Created by Lucas Cesar on 06/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import UIKit
import Combine

final class HomeViewModel: ObservableObject {
    
    enum State {
        case loading, empty
        case error(CustomError)
    }
    
    // MARK: - Variables
    @Published var repositories: [Repository] = []
    @Published var currentState: State = State.empty
    private var gitResponse: Repositories?
    private var provider: ServiceProvider<HomeService>?
    private var currentPage = 0
    private var makingRequest = false
    private var reposPerPage: Int
    
    // MARK: - Initializer
    init(provider: ServiceProvider<HomeService> = ServiceProvider<HomeService>(), reposPerPage: Int = 15) {
        self.provider = provider
        self.reposPerPage = reposPerPage
    }
    
    
    // MARK: - Public Functions
    func resetData() {
        currentState = State.empty
        gitResponse = nil
        currentPage = 0
        
        loadRepositories()
    }
    
    func loadRepositories() {
        if shouldFetchMoreRepos() {
            currentPage += 1
            currentState = .loading
            makingRequest = true
            
            provider?.load(
                service: .bestRepo(page: currentPage, reposPerPage: reposPerPage),
                decodeType: Repositories.self,
                completion: { [weak self] result in
                    self?.makingRequest = false
                    self?.currentState = .empty
                    switch result {
                    case .success(let repositories):
                        self?.gitResponse = repositories
                        if self?.currentPage == 1 {
                            self?.repositories = repositories.items
                        } else  {
                            self?.repositories.append(contentsOf: repositories.items)
                        }
                    case .failure(let error):
                        self?.currentState = .error(error)
                    }
                }
            )
        }
    }
    
    // MARK: - Private Functions
    private func shouldFetchMoreRepos() -> Bool {
        return currentPage < limitOfPages() && !makingRequest
    }
    
    private func limitOfPages() -> Int {
        let pageLimit = (gitResponse?.totalCount ?? 1) / reposPerPage
        let pageLimitRounded = Int(CGFloat(pageLimit).rounded(.up))
        return pageLimitRounded > 0 ? pageLimitRounded : 1
    }
}

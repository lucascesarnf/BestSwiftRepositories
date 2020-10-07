//
//  HomeViewController.swift
//  BestSwiftRepositories
//
//  Created by Lucas Cesar on 06/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Combine

final class HomeViewController: BaseViewController<UITableView> {
    
    @ObservedObject var viewModel: HomeViewModel
    
    private let cellId = "RepositoryCell"
    private var tableView: UITableView?
    private var cancellables: Set<AnyCancellable> = []
    private var repositories:[Repository] = []
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = customView
        
        setupTableView()
        bindViewModel()
        setupRefreshControll()
        
        viewModel.loadRepositories()
    }
    
    private func bindViewModel() {
        bindViewModelState()
        bindViewModelRepositories()
    }
    
    private func bindViewModelState() {
        viewModel.$currentState.sink { [weak self] state in
            switch state {
            case .loading:
                if self?.repositories.count == 0 {
                    self?.startActivityIndicator()
                }
            case .empty:
                self?.refreshControl.endRefreshing()
                self?.stopActivityIndicator()
            case .error(let error):
                self?.showAlert(title: error.title, message: error.errorDescription ?? "")
            }
        }.store(in: &cancellables)
    }
    
    private func bindViewModelRepositories() {
        viewModel.$repositories.sink { [weak self] repositories in
            self?.repositories = repositories
            self?.tableView?.reloadData()
            
            if repositories.count == 0 {
                self?.tableView?.setEmpty()
            } else {
                self?.tableView?.restore()
            }
        }.store(in: &cancellables)
    }
    
    private func setupTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(RepositoryCell.self, forCellReuseIdentifier: cellId)
        tableView?.rowHeight = 150
    }
    
    private func setupRefreshControll() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView?.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        viewModel.resetData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RepositoryCell else {
            return UITableViewCell()
        }
        
        let repository = repositories[indexPath.row]
        cell.repository = repository
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == repositories.count / 2 || indexPath.row == repositories.count - 4 {
            viewModel.loadRepositories()
        }
    }
}



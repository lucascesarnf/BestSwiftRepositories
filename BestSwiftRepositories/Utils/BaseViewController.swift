//
//  BaseViewController.swift
//  BestSwiftRepositories
//
//  Created by Lucas Cesar on 06/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import UIKit

class BaseViewController<CustomView: UIView>: UIViewController {
    
    // MARK: - Variables
    private var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    public var customView: CustomView {
         guard let customView = view as? CustomView else {
             fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
         }
         return customView
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    // MARK: - Common Methods
    func startActivityIndicator() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        view.addSubview(spinner)
        
        spinner.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
        )
    }
    
    func stopActivityIndicator() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}




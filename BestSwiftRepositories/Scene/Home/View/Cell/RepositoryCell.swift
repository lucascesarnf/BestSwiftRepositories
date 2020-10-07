//
//  RepositoryCell.swift
//  BestSwiftRepositories
//
//  Created by Lucas Cesar on 06/10/20.
//  Copyright © 2020 Lucas Cesar. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {
    
    var repository: Repository? {
        didSet {
            repositoryNameLabel.text = repository?.name
            ownerNameLabel.text = repository?.owner.ownerName
            starNumberLabel.text = "\(repository?.stars ?? 0)"
            repositoryDescriptionLabel.text = repository?.description
            
            let url = URL(string: repository?.owner.ownerImage ?? "")
            ownertImage.kf.setImage(with: url)
        }
    }
    
    private let repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let repositoryDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var starNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let ownertImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(repositoryNameLabel)
        addSubview(ownerNameLabel)
        addSubview(repositoryDescriptionLabel)
        addSubview(starNumberLabel)
        addSubview(ownertImage)
        addSubview(starImage)
        
        ownertImage.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            paddingTop: 5,
            paddingLeft: 10,
            paddingBottom: 5,
            width: 90
        )
        
        repositoryNameLabel.anchor(
            top: topAnchor,
            left: ownertImage.rightAnchor,
            right: rightAnchor,
            paddingTop: 20,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        repositoryDescriptionLabel.anchor(
            top: repositoryNameLabel.bottomAnchor,
            left: ownertImage.rightAnchor,
            right: rightAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        ownerNameLabel.anchor(
            top: repositoryDescriptionLabel.bottomAnchor,
            left: ownertImage.rightAnchor,
            right: rightAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        starNumberLabel.anchor(
            top: repositoryDescriptionLabel.bottomAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 15,
            paddingLeft: 5,
            paddingBottom: 15,
            paddingRight: 10
        )
        
        starImage.anchor(
            top: repositoryDescriptionLabel.bottomAnchor,
            bottom: bottomAnchor,
            right: starNumberLabel.leftAnchor,
            paddingTop: 15,
            paddingLeft: 5,
            paddingBottom: 15,
            paddingRight: 10,
            height: 20
        )
    }
}

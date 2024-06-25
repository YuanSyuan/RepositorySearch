//
//  DetailViewController.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/23.
//

import UIKit

import UIKit

class DetailViewController: UIViewController {
    
    var repository: Repository?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let watchersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        
        if let repository = repository {
            titleLabel.text = repository.name
            nameLabel.text = repository.fullName
            languageLabel.text = "Written in \(repository.language ?? "N/A")"
            starsLabel.text = "\(repository.stargazersCount) stars"
            watchersLabel.text = "\(repository.watchersCount) watchers"
            forksLabel.text = "\(repository.forksCount) forks"
            issuesLabel.text = "\(repository.openIssuesCount) open issues"
            
            if let url = URL(string: repository.owner.avatarURL) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.avatarImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(languageLabel)
        view.addSubview(starsLabel)
        view.addSubview(watchersLabel)
        view.addSubview(forksLabel)
        view.addSubview(issuesLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            languageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            starsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            starsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            watchersLabel.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: 8),
            watchersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            forksLabel.topAnchor.constraint(equalTo: watchersLabel.bottomAnchor, constant: 8),
            forksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            issuesLabel.topAnchor.constraint(equalTo: forksLabel.bottomAnchor, constant: 8),
            issuesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            issuesLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}


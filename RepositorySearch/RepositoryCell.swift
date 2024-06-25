//
//  RepositoryCell.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/23.
//

import UIKit

class RepositoryCell: UITableViewCell {
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
  
        
        NSLayoutConstraint.activate([
                    avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    avatarImageView.widthAnchor.constraint(equalToConstant: 80),
                    avatarImageView.heightAnchor.constraint(equalToConstant: 80),
                    
                    nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                    nameLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
                    nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    
                    descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
                    descriptionLabel.topAnchor.constraint(equalTo: centerYAnchor),
                    descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
                ])
    }
}

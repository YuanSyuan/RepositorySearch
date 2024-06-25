//
//  GithubModel.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/23.
//

import Foundation

struct Owner: Codable {
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}

struct Repository: Codable {
    let name: String
    let fullName: String
    let description: String?
    let owner: Owner
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int

    enum CodingKeys: String, CodingKey {
        case name, description, owner, language
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
    }
}

struct SearchResponse: Codable {
    let items: [Repository]
}



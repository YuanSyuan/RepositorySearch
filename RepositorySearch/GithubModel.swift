//
//  GithubModel.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/23.
//

import Foundation

struct Owner: Codable {
    let avatar_url: String
}

struct Repository: Codable {
    let name: String
    let description: String?
    let owner: Owner
    let language: String?
    let stargazers_count: Int
    let watchers_count: Int
    let forks_count: Int
    let open_issues_count: Int
}

struct SearchResponse: Codable {
    let items: [Repository]
}


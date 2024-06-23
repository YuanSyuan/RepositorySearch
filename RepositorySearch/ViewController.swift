//
//  ViewController.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/19.
//

import UIKit

class ViewController: UIViewController {
    let githubManager = GithubManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        githubManager.searchRepositories(query: "apple") { result in
                    switch result {
                    case .success(let repositories):
                        print("Repositories found: \(repositories.count)")
                        for repo in repositories {
                                            print("""
                                            Name: \(repo.name)
                                            Description: \(repo.description ?? "No description")
                                            Owner Icon: \(repo.owner.avatar_url)
                                            Language: \(repo.language ?? "N/A")
                                            Stars: \(repo.stargazers_count)
                                            Watchers: \(repo.watchers_count)
                                            Forks: \(repo.forks_count)
                                            Issues: \(repo.open_issues_count)
                                            """)
                                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
        
        // Do any additional setup after loading the view.
    }
    
    // To-do
    /*
     週六
     1. 先刻 UI 4h
     MainVC
     - tableView, tableView header, two cells(search bar, search cell)
     
     DetailVC
     - 比較簡單
     
     2. 2h
     串 github API
     修改兩個頁面的顯示邏輯
     
     3. 2h
     MJRefresh 完成下拉刷新
     alert handle
     
     週日
     4. 3h
     Refactor

     */
}


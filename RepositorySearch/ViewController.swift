//
//  ViewController.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/19.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let githubManager = GithubManager()
    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
        tableView.register(SearchBarCell.self, forCellReuseIdentifier: "SearchBarCell")
        
        githubManager.searchRepositories(query: "swift") { result in
            switch result {
            case .success(let repositories):
                
                self.repositories = repositories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                print("Repositories found: \(repositories.count)")
                for repo in repositories {
                    print("""
                                            Name: \(repo.name)
                                            Description: \(repo.description ?? "No description")
                                            Owner Icon: \(repo.owner.avatarURL)
                                            Language: \(repo.language ?? "N/A")
                                            Stars: \(repo.stargazersCount)
                                            Watchers: \(repo.watchersCount)
                                            Forks: \(repo.forksCount)
                                            Issues: \(repo.openIssuesCount)
                                            """)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        let headerLabel = UILabel()
        headerLabel.text = "Repository Search"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 36)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        ])
        
        tableView.tableHeaderView = headerView
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarCell", for: indexPath) as? SearchBarCell else {
                return UITableViewCell()
            }
            //               cell.searchBar.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else {
                return UITableViewCell()
            }
            
            let repository = repositories[indexPath.row]
            cell.nameLabel.text = repository.fullName
            cell.descriptionLabel.text = repository.description ?? "No description"
            if let url = URL(string: repository.owner.avatarURL) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell.avatarImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            guard indexPath.section == 1 else { return }
            
            let detailVC = DetailViewController()
            detailVC.repository = repositories[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
                    return 50
                } else {
                    return 100
                }
            }
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

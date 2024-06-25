//
//  SearchViewController.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/19.
//

import UIKit

class SearchViewController: UIViewController {
    
    let tableView = UITableView()
    let githubManager = GithubManager()
    var repositories: [Repository] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupRefreshControl()
        hideKeyboardWhenTappedAround()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
        tableView.register(SearchBarCell.self, forCellReuseIdentifier: "SearchBarCell")
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
    
    //MARK: - RefreshControl
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        guard let query = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SearchBarCell)?.searchBar.text, !query.isEmpty else {
            showAlert(title: "Oops!", message: "The data couldn't be read because it is missing.")
            return
        }
        
        githubManager.searchRepositories(query: query) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.refreshControl.endRefreshing()
        }))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
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
            
            cell.searchBar.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else {
                return UITableViewCell()
            }

            let repository = repositories[indexPath.row]
            cell.configureCell(with: repository)
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 1 else { return }
        
        let detailVC = DetailViewController()
        detailVC.repository = repositories[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, !query.isEmpty else { return }
        
        githubManager.searchRepositories(query: query) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            repositories.removeAll()
            tableView.reloadData()
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

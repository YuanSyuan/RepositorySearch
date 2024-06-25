//
//  GithubManager.swift
//  RepositorySearch
//
//  Created by 李芫萱 on 2024/6/20.
//

import Foundation

class GithubManager {
    func searchRepositories(query: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let urlString = "https://api.github.com/search/repositories?q=\(query)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
 
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    print("OK")
                case 304:
                    print("Not modified")
                    return
                case 422:
                    print("Validation failed, or the endpoint has been spammed")
                    return
                case 503:
                    print("Service unavailable")
                    return
                default:
                    print("Unhandled HTTP response status: \(httpResponse.statusCode)")
                    return
                }
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                completion(.success(searchResponse.items))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        
        task.resume()
    }
}


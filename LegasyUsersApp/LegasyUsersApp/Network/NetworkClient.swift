//
//  NetworkClient.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 15.03.2026.
//

import Foundation

enum NetworkError: String, Error {
    case error = "Network error"
}

protocol NetworkClientProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

final class NetworkClient: NetworkClientProtocol {
    let baseUrl = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {

        URLSession.shared.dataTask(with: baseUrl) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.error))
                }
                return
            }

            do {
                let decodedUsers = try JSONDecoder().decode([User].self, from: data)

                DispatchQueue.main.async {
                    completion(.success(decodedUsers))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.error))
                }
            }

        }.resume()
    }
}

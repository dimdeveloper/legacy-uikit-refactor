//
//  NetworkClient.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 15.03.2026.
//

import Foundation

enum NetworkError: String, Error {
    case requestFailed
    case invalidData
    case decodingFailed
}

protocol NetworkClientProtocol {
    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkClient: NetworkClientProtocol {

    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {

        URLSession.shared.dataTask(with: url) { data, _, error in

            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.requestFailed))
                }
                return
            }

            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(decoded))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingFailed))
                }
            }

        }.resume()
    }
}

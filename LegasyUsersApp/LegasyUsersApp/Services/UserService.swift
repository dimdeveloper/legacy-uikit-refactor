//
//  UserService.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 15.03.2026.
//

import Foundation

protocol UserService {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

final class DefaultUserService: UserService {

    private let networkClient: NetworkClientProtocol

    private let url =
        URL(string: "https://jsonplaceholder.typicode.com/users")!

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {

        networkClient.request(url: url, completion: completion)
    }
}

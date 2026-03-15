// User.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 12.03.2026.

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}



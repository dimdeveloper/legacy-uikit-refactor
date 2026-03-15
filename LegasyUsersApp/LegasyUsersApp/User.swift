// User.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 12.03.2026.

import Foundation

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

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct Company: Codable {
    let name: String
}

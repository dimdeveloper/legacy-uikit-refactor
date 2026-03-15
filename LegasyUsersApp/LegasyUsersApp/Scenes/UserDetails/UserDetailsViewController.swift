//
//  UserDetailsViewController.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 12.03.2026.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var user: User?

    private let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "User Details"

        view.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.textColor = .black

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        if let user = user {

            textView.text = """
            Name: \(user.name)

            Username: \(user.username)

            Email: \(user.email)

            Phone: \(user.phone)

            Website: \(user.website)

            Company: \(user.company.name)

            City: \(user.address.city)
            """
        }
    }
}

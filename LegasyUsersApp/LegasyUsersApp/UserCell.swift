// UserCell.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 12.03.2026.

import UIKit

class UserCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let companyLabel = UILabel()

    private let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel.font = .boldSystemFont(ofSize: 16)

        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = .darkGray

        companyLabel.font = .systemFont(ofSize: 13)
        companyLabel.textColor = .gray

        stackView.axis = .vertical
        stackView.spacing = 4

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(companyLabel)

        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(name: String, username: String, company: String) {
        nameLabel.text = name
        usernameLabel.text = "@\(username)"
        companyLabel.text = company
    }
}

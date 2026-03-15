//  ViewController.swift
//  LegasyUsersApp
//
//  Created by Dmytro Melnyk on 12.03.2026.
//

import UIKit

class UsersViewController: UIViewController {

    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let refreshControl = UIRefreshControl()

    private var users: [User] = []
    private var filteredUsers: [User] = []
    private var isSearching = false
    private var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Users"
        view.backgroundColor = .white

        setupSearchBar()
        setupTableView()
        setupLoadingIndicator()

        loadUsers()
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

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")

        refreshControl.addTarget(self,
                                 action: #selector(refreshPulled),
                                 for: .valueChanged)

        tableView.refreshControl = refreshControl
    }

    private func setupLoadingIndicator() {

        view.addSubview(loadingIndicator)

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func loadUsers() {
        loadingIndicator.startAnimating()
        userService.fetchUsers() { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .failure(let error):
                print(error)
                self.loadingIndicator.stopAnimating()
                self.showError(error.localizedDescription)
            case .success(let users):
                self.users = users
                self.filteredUsers = users
                self.loadingIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }

    @objc
    private func refreshPulled() {
        loadUsers()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
        }
    }

    private func showError(_ message: String) {

        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))

        present(alert, animated: true)
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        return filteredUsers.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "UserCell",
            for: indexPath
        ) as? UserCell else {
            return UITableViewCell()
        }

        let user = filteredUsers[indexPath.row]

        cell.configure(
            name: user.name,
            username: user.username,
            company: user.company.name
        )

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let user = filteredUsers[indexPath.row]

        let detailVC = UserDetailsViewController()
        detailVC.user = user

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension UsersViewController: UISearchBarDelegate {
    private func setupSearchBar() {
        searchBar.placeholder = "Search users"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {

        if searchText.isEmpty {

            filteredUsers = users
            isSearching = false

        } else {

            isSearching = true
            let query = searchText.lowercased()
            filteredUsers = users.filter {
                $0.name.lowercased().contains(query) ||
                $0.username.lowercased().contains(query)
            }
        }

        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredUsers = users
        tableView.reloadData()
    }
}

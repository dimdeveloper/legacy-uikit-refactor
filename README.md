
# UIKit Legacy Refactor Demo

This project demonstrates refactoring a legacy UIKit codebase into a more maintainable architecture.

The application loads users from a public API and displays them in a table view.

The original implementation contained a **Massive ViewController** with tightly coupled networking and UI logic.

The refactor extracts networking into a dedicated client, introduces a service layer, and simplifies the ViewController.

## Legacy Problems

The original implementation had several architectural issues:

• Massive ViewController (~450 lines)
• Networking logic inside ViewController
• Tight coupling between UI and data fetching
• Hard to test
• No separation of concerns

## Before (Legacy Implementation)

Networking and UI logic were tightly coupled inside the ViewController:

```swift
func fetchUsers() {

    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

    URLSession.shared.dataTask(with: url) { data, response, error in

        if let data = data {
            do {
                let users = try JSONDecoder().decode([User].self, from: data)

                DispatchQueue.main.async {
                    self.users = users
                    self.tableView.reloadData()
                }

            } catch {
                print(error)
            }
        }

    }.resume()
}
```
## After (Refactored Implementation)

Networking was extracted into a reusable `NetworkClient` and a `UserService`.

ViewController now focuses only on UI updates:

```swift
private func loadUsers() {

    userService.fetchUsers { [weak self] result in
        guard let self else { return }

        switch result {

        case .success(let users):
            self.users = users
            self.tableView.reloadData()

        case .failure:
            self.showError()
        }
    }
}
```
## Architecture

```
UsersViewController
        ↓
     UserService
        ↓
    NetworkClient
        ↓
      API
```
## Project Structure

```
App
 ├─ Scenes
 │   └─ Users
 │       ├─ UsersViewController
 │       └─ UserCell
 │
 ├─ Services
 │   └─ UserService
 │
 ├─ Network
 │   └─ NetworkClient
 │
 └─ Models
     └─ User
```
## Improvements Introduced

• Extracted networking into `NetworkClient`
• Introduced `UserService` abstraction
• Added Dependency Injection
• Reduced responsibilities of ViewController
• Improved separation of concerns

## Future Improvements

• Pagination support
• Response caching
• Unit tests for services
• Coordinator-based navigation

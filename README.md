# GitHub List (iOS)

An iOS app that lists the most-starred Java repositories on GitHub and, for each one, its open pull requests. Built with UIKit and MVVM, consuming the public GitHub REST API.

There is also an Android version of the same app: [GitHubList_android](https://github.com/filizzolalucca/GitHubList_android).

<p>
  <img src="https://img.shields.io/badge/Swift-5-F05138?logo=swift&logoColor=white" alt="Swift 5">
  <img src="https://img.shields.io/badge/UIKit-blue?logo=apple&logoColor=white" alt="UIKit">
  <img src="https://img.shields.io/badge/iOS-14+-lightgrey?logo=apple" alt="iOS 14+">
  <img src="https://img.shields.io/badge/CocoaPods-EE3322?logo=cocoapods&logoColor=white" alt="CocoaPods">
</p>

## Features

- **Repositories**: most-starred Java repositories, showing the name, description, owner, stars and forks
- **Pull requests**: tap a repository to see its pull requests, with title, description and author
- Loading of avatars and images from the network with caching
- Success and error handling for every request

## Tech stack

| | |
|---|---|
| UI | UIKit with XIB-based screens and cells, `UITableView` |
| Architecture | MVVM with providers and dependency injection (Resolver) |
| Networking | Alamofire, with a small API manager and typed service errors |
| Images | SDWebImage |
| Dependencies | CocoaPods |

## API

| Endpoint | Screen |
|---|---|
| `GET /search/repositories?q=language:Java&sort=stars` | Repository list |
| `GET /repos/{owner}/{repo}/pulls` | Pull request list |

## Project structure

```
GitHubList/
├── Commum/        # API manager, endpoints, constants and extensions
├── Modules/
│   ├── Home/      # Repository list (view controller, cell, view model)
│   └── Pull/      # Pull request list (view controller, cell, view model)
├── Provider/      # Data providers for each module
└── Resources/     # Launch screen and assets
```

## Getting started

1. Clone the repository:
   ```bash
   git clone https://github.com/filizzolalucca/gitListApp_ios.git
   ```
2. Install the pods (the `Pods` folder is already included, so this step is only needed if you update them):
   ```bash
   pod install
   ```
3. Open `GitHubList.xcworkspace` in Xcode and press **⌘R**.

## Author

**Lucca Filizzola** · [@filizzolalucca](https://github.com/filizzolalucca)

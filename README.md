# GithubUsers App using Clean Architecture and MVVM

The purpose of this project is to show the basic aspects of Clean Architecture and MVVM design pattern, dependency injection, Combine, SwiftUI and CoreData Framework

## Layers

* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations (Services) + API (Network) + Persistence DB (CoreData))
* **Presentation Layer (MVVM)** = ViewModels + Views

## Requirements

Xcode 15.4

iOS 15.0

## Project Structure

To keep all current and upcoming iOS projects aligned, we standardize an iOS project’s file organization by following this below structure:

```
.
├── GithubUsers
│   ├── Application
│   │   └── GithubUsersApp.swift
│   ├── Presentation
│   │   ├── Scene
│   │   ├── Utils
│   │   │   ├── Common
│   │   │   └── Extensions
│   ├── Domain
│   │   ├── Entities
│   │   ├── UseCases
│   │   └── InterfaceRepositories
│   ├── Data
│   │   ├── Services
│   │   ├── API
│   │   │   ├── Network
│   │   │   ├── Parser
│   │   │   └── EndPoint
│   │   ├── Data
│   │   │   ├── Extensions
│   │   │   ├── CoreDataUtils.swift
│   │   │   ├── CoreDataHelper.swift
│   │   │   ├── Persistence.swift
│   │   │   └── GithubUsers.xcdatamodeld
│   ├── Configuration
│   │   ├── Font.swift
│   │   ├── Color.swift
│   │   └── Sizing.swift
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   ├── ColorPalette.xcassets
│   │   ├── Localizable.xcstrings
│   │   └── Launch Screen.storyboard
│   └── Preview Content
│       └──Preview Assets.xcassets
├── GithubUsersTests
│   ├── GithubUsers.xctestplan
│   ├── PresentationTests
│   └── DataTests
│       ├── API
│       └── CoreData
└── GithubUsersUITests
    └──  GithubUsersUITests.swift
```

## **Screenshot**

#### Light Mode

<img width="300" src="images/UserList-Light.png" alt="MVVM SWiftUI list" />        <img width="300" src="images/UserDetail-Light.png"" alt="MVVM SWiftUI detail"/>



#### Dark Mode

<img width="300" src="images/UserList-Dark.png" alt="MVVM SWiftUI list" />        <img width="300" src="images/UserDetail-Dark.png" alt="MVVM SWiftUI detail"/>


## Thanks for viewing

Please provide your feedback in the issues section.

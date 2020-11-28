// To parse the JSON, add this file to your project and do:
//
//   let repositories = try? newJSONDecoder().decode(Repositories.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
//     if let repositories = repositories {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Repositories
struct Repositories: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repository]?

    enum CodingKeys: String, CodingKey {
        case totalCount
        case incompleteResults
        case items
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.itemTask(with: url) { item, response, error in
//     if let item = item {
//       ...
//     }
//   }
//   task.resume()




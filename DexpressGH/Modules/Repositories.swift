// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let repositories = try Repositories(json)
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
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case totalCount
        case incompleteResults
        case items
    }
}

// MARK: Repositories convenience initializers and mutators

extension Repositories {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Repositories.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        totalCount: Int?? = nil,
        incompleteResults: Bool?? = nil,
        items: [Item]?? = nil
    ) -> Repositories {
        return Repositories(
            totalCount: totalCount ?? self.totalCount,
            incompleteResults: incompleteResults ?? self.incompleteResults,
            items: items ?? self.items
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let item = try Item(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.itemTask(with: url) { item, response, error in
//     if let item = item {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Item
struct Item: Codable {
    let idx: Int?
    let name, fullName: String?
    let owner: Owner?
    let itemDescription: String?
    let fork: Bool?
    let url: String?
    let stargazersCount, watchersCount: Int?
    let language: String?
    let forksCount: Int?
    let forks, watchers: Int?

    enum CodingKeys: String, CodingKey {
        case idx = "id"
        case name
        case fullName
        case owner
        case itemDescription = "description"
        case fork, url
        case stargazersCount = "stargazers_count"
        case watchersCount
        case language
        case forksCount
        case forks
        case watchers
    }
}

// MARK: Item convenience initializers and mutators

extension Item {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Item.self, from: data)
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

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

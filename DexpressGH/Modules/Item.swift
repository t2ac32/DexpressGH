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
    let id: Int?
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
        case id
        case name
        case fullName
        case owner
        case itemDescription = "description"
        case fork, url
        case stargazersCount
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

    func with(
        id: Int?? = nil,
        name: String?? = nil,
        fullName: String?? = nil,
        owner: Owner?? = nil,
        itemDescription: String?? = nil,
        fork: Bool?? = nil,
        url: String?? = nil,
        stargazersCount: Int?? = nil,
        watchersCount: Int?? = nil,
        language: String?? = nil,
        forksCount: Int?? = nil,
        forks: Int?? = nil,
        watchers: Int?? = nil
    ) -> Item {
        return Item(
            id: id ?? self.id,
            name: name ?? self.name,
            fullName: fullName ?? self.fullName,
            owner: owner ?? self.owner,
            itemDescription: itemDescription ?? self.itemDescription,
            fork: fork ?? self.fork,
            url: url ?? self.url,
            stargazersCount: stargazersCount ?? self.stargazersCount,
            watchersCount: watchersCount ?? self.watchersCount,
            language: language ?? self.language,
            forksCount: forksCount ?? self.forksCount,
            forks: forks ?? self.forks,
            watchers: watchers ?? self.watchers
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

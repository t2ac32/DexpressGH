// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let owner = try Owner(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.ownerTask(with: url) { owner, response, error in
//     if let owner = owner {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    
    let receivedEventsURL: String?
    
    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID
        case url
        case htmlURL
        case followersURL
        case subscriptionsURL
        case organizationsURL
        case reposURL
        case receivedEventsURL
        case siteAdmin
    }
}

// MARK: Owner convenience initializers and mutators

extension Owner {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Owner.self, from: data)
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
        login: String?? = nil,
        id: Int?? = nil,
        avatarURL: String?? = nil,
        gravatarID: String?? = nil,
        url: String?? = nil,
        htmlURL: String?? = nil,
        followersURL: String?? = nil,
        subscriptionsURL: String?? = nil,
        organizationsURL: String?? = nil,
        reposURL: String?? = nil,
        receivedEventsURL: String?? = nil,
        siteAdmin: Bool?? = nil
    ) -> Owner {
        return Owner(
            login: login ?? self.login,
            id: id ?? self.id,
            avatarURL: avatarURL ?? self.avatarURL,
            gravatarID: gravatarID ?? self.gravatarID,
            url: url ?? self.url,
            htmlURL: htmlURL ?? self.htmlURL,
            followersURL: followersURL ?? self.followersURL,
            subscriptionsURL: subscriptionsURL ?? self.subscriptionsURL,
            organizationsURL: organizationsURL ?? self.organizationsURL,
            reposURL: reposURL ?? self.reposURL,
            receivedEventsURL: receivedEventsURL ?? self.receivedEventsURL,
            siteAdmin: siteAdmin ?? self.siteAdmin
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

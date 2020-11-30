//
//  Owner.swift
//  DexpressGH
//
//  Created by Tracer on 30/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//
import Foundation

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


// MARK: - Owner
struct Owner: Codable {
    let login: Login?
    let id: Int?
    let nodeID: NodeID?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL: FollowingURL?
    let gistsURL: GistsURL?
    let starredURL: StarredURL?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: EventsURL?
    let receivedEventsURL: String?
    let type: TypeEnum?
    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
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
        login: Login?? = nil,
        id: Int?? = nil,
        nodeID: NodeID?? = nil,
        avatarURL: String?? = nil,
        gravatarID: String?? = nil,
        url: String?? = nil,
        htmlURL: String?? = nil,
        followersURL: String?? = nil,
        followingURL: FollowingURL?? = nil,
        gistsURL: GistsURL?? = nil,
        starredURL: StarredURL?? = nil,
        subscriptionsURL: String?? = nil,
        organizationsURL: String?? = nil,
        reposURL: String?? = nil,
        eventsURL: EventsURL?? = nil,
        receivedEventsURL: String?? = nil,
        type: TypeEnum?? = nil,
        siteAdmin: Bool?? = nil
    ) -> Owner {
        return Owner(
            login: login ?? self.login,
            id: id ?? self.id,
            nodeID: nodeID ?? self.nodeID,
            avatarURL: avatarURL ?? self.avatarURL,
            gravatarID: gravatarID ?? self.gravatarID,
            url: url ?? self.url,
            htmlURL: htmlURL ?? self.htmlURL,
            followersURL: followersURL ?? self.followersURL,
            followingURL: followingURL ?? self.followingURL,
            gistsURL: gistsURL ?? self.gistsURL,
            starredURL: starredURL ?? self.starredURL,
            subscriptionsURL: subscriptionsURL ?? self.subscriptionsURL,
            organizationsURL: organizationsURL ?? self.organizationsURL,
            reposURL: reposURL ?? self.reposURL,
            eventsURL: eventsURL ?? self.eventsURL,
            receivedEventsURL: receivedEventsURL ?? self.receivedEventsURL,
            type: type ?? self.type,
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

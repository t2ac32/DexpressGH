//
//  Enums.swift
//  DexpressGH
//
//  Created by Tracer on 30/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

enum DefaultBranch: String, Codable {
    case main = "main"
    case master = "master"
}

enum EventsURL: String, Codable {
    case httpsAPIGithubCOMUsersT2Ac32EventsPrivacy = "https://api.github.com/users/t2ac32/events{/privacy}"
}

enum FollowingURL: String, Codable {
    case httpsAPIGithubCOMUsersT2Ac32FollowingOtherUser = "https://api.github.com/users/t2ac32/following{/other_user}"
}

enum GistsURL: String, Codable {
    case httpsAPIGithubCOMUsersT2Ac32GistsGistID = "https://api.github.com/users/t2ac32/gists{/gist_id}"
}

enum Login: String, Codable {
    case t2Ac32 = "t2ac32"
}

enum NodeID: String, Codable {
    case mdq6VXNlcjMyNzU0MzQ = "MDQ6VXNlcjMyNzU0MzQ="
}

enum StarredURL: String, Codable {
    case httpsAPIGithubCOMUsersT2Ac32StarredOwnerRepo = "https://api.github.com/users/t2ac32/starred{/owner}{/repo}"
}

enum TypeEnum: String, Codable {
    case user = "User"
}

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
    let nodeID, name, fullName: String?
    let itemPrivate: Bool?
    let owner: Owner?
    let htmlURL: String?
    let itemDescription: String?
    let fork: Bool?
    let url, forksURL: String?
    let keysURL, collaboratorsURL: String?
    let teamsURL, hooksURL: String?
    let issueEventsURL: String?
    let eventsURL: String?
    let assigneesURL, branchesURL: String?
    let tagsURL: String?
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String?
    let statusesURL: String?
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String?
    let subscriptionURL: String?
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String?
    let contentsURL, compareURL: String?
    let mergesURL: String?
    let archiveURL: String?
    let downloadsURL: String?
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String?
    let labelsURL, releasesURL: String?
    let deploymentsURL: String?
    let createdAt, updatedAt, pushedAt: Date?
    let gitURL, sshURL: String?
    let cloneURL: String?
    let svnURL: String?
    let homepage: String?
    let size, stargazersCount, watchersCount: Int?
    let language: String?
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool?
    let hasPages: Bool?
    let forksCount: Int?
    let mirrorURL: JSONNull?
    let archived, disabled: Bool?
    let openIssuesCount: Int?
    let license: License?
    let forks, openIssues, watchers: Int?
    let defaultBranch: DefaultBranch?
    let score: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID
        case name
        case fullName
        case itemPrivate
        case owner
        case htmlURL
        case itemDescription
        case fork, url
        case forksURL
        case keysURL
        case collaboratorsURL
        case teamsURL
        case hooksURL
        case issueEventsURL
        case eventsURL
        case assigneesURL
        case branchesURL
        case tagsURL
        case blobsURL
        case gitTagsURL
        case gitRefsURL
        case treesURL
        case statusesURL
        case languagesURL
        case stargazersURL
        case contributorsURL
        case subscribersURL
        case subscriptionURL
        case commitsURL
        case gitCommitsURL
        case commentsURL
        case issueCommentURL
        case contentsURL
        case compareURL
        case mergesURL
        case archiveURL
        case downloadsURL
        case issuesURL
        case pullsURL
        case milestonesURL
        case notificationsURL
        case labelsURL
        case releasesURL
        case deploymentsURL
        case createdAt
        case updatedAt
        case pushedAt
        case gitURL
        case sshURL
        case cloneURL
        case svnURL
        case homepage, size
        case stargazersCount
        case watchersCount
        case language
        case hasIssues
        case hasProjects
        case hasDownloads
        case hasWiki
        case hasPages
        case forksCount
        case mirrorURL
        case archived, disabled
        case openIssuesCount
        case license, forks
        case openIssues
        case watchers
        case defaultBranch
        case score
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
        nodeID: String?? = nil,
        name: String?? = nil,
        fullName: String?? = nil,
        itemPrivate: Bool?? = nil,
        owner: Owner?? = nil,
        htmlURL: String?? = nil,
        itemDescription: String?? = nil,
        fork: Bool?? = nil,
        url: String?? = nil,
        forksURL: String?? = nil,
        keysURL: String?? = nil,
        collaboratorsURL: String?? = nil,
        teamsURL: String?? = nil,
        hooksURL: String?? = nil,
        issueEventsURL: String?? = nil,
        eventsURL: String?? = nil,
        assigneesURL: String?? = nil,
        branchesURL: String?? = nil,
        tagsURL: String?? = nil,
        blobsURL: String?? = nil,
        gitTagsURL: String?? = nil,
        gitRefsURL: String?? = nil,
        treesURL: String?? = nil,
        statusesURL: String?? = nil,
        languagesURL: String?? = nil,
        stargazersURL: String?? = nil,
        contributorsURL: String?? = nil,
        subscribersURL: String?? = nil,
        subscriptionURL: String?? = nil,
        commitsURL: String?? = nil,
        gitCommitsURL: String?? = nil,
        commentsURL: String?? = nil,
        issueCommentURL: String?? = nil,
        contentsURL: String?? = nil,
        compareURL: String?? = nil,
        mergesURL: String?? = nil,
        archiveURL: String?? = nil,
        downloadsURL: String?? = nil,
        issuesURL: String?? = nil,
        pullsURL: String?? = nil,
        milestonesURL: String?? = nil,
        notificationsURL: String?? = nil,
        labelsURL: String?? = nil,
        releasesURL: String?? = nil,
        deploymentsURL: String?? = nil,
        createdAt: Date?? = nil,
        updatedAt: Date?? = nil,
        pushedAt: Date?? = nil,
        gitURL: String?? = nil,
        sshURL: String?? = nil,
        cloneURL: String?? = nil,
        svnURL: String?? = nil,
        homepage: String?? = nil,
        size: Int?? = nil,
        stargazersCount: Int?? = nil,
        watchersCount: Int?? = nil,
        language: String?? = nil,
        hasIssues: Bool?? = nil,
        hasProjects: Bool?? = nil,
        hasDownloads: Bool?? = nil,
        hasWiki: Bool?? = nil,
        hasPages: Bool?? = nil,
        forksCount: Int?? = nil,
        mirrorURL: JSONNull?? = nil,
        archived: Bool?? = nil,
        disabled: Bool?? = nil,
        openIssuesCount: Int?? = nil,
        license: License?? = nil,
        forks: Int?? = nil,
        openIssues: Int?? = nil,
        watchers: Int?? = nil,
        defaultBranch: DefaultBranch?? = nil,
        score: Int?? = nil
    ) -> Item {
        return Item(
            id: id ?? self.id,
            nodeID: nodeID ?? self.nodeID,
            name: name ?? self.name,
            fullName: fullName ?? self.fullName,
            itemPrivate: itemPrivate ?? self.itemPrivate,
            owner: owner ?? self.owner,
            htmlURL: htmlURL ?? self.htmlURL,
            itemDescription: itemDescription ?? self.itemDescription,
            fork: fork ?? self.fork,
            url: url ?? self.url,
            forksURL: forksURL ?? self.forksURL,
            keysURL: keysURL ?? self.keysURL,
            collaboratorsURL: collaboratorsURL ?? self.collaboratorsURL,
            teamsURL: teamsURL ?? self.teamsURL,
            hooksURL: hooksURL ?? self.hooksURL,
            issueEventsURL: issueEventsURL ?? self.issueEventsURL,
            eventsURL: eventsURL ?? self.eventsURL,
            assigneesURL: assigneesURL ?? self.assigneesURL,
            branchesURL: branchesURL ?? self.branchesURL,
            tagsURL: tagsURL ?? self.tagsURL,
            blobsURL: blobsURL ?? self.blobsURL,
            gitTagsURL: gitTagsURL ?? self.gitTagsURL,
            gitRefsURL: gitRefsURL ?? self.gitRefsURL,
            treesURL: treesURL ?? self.treesURL,
            statusesURL: statusesURL ?? self.statusesURL,
            languagesURL: languagesURL ?? self.languagesURL,
            stargazersURL: stargazersURL ?? self.stargazersURL,
            contributorsURL: contributorsURL ?? self.contributorsURL,
            subscribersURL: subscribersURL ?? self.subscribersURL,
            subscriptionURL: subscriptionURL ?? self.subscriptionURL,
            commitsURL: commitsURL ?? self.commitsURL,
            gitCommitsURL: gitCommitsURL ?? self.gitCommitsURL,
            commentsURL: commentsURL ?? self.commentsURL,
            issueCommentURL: issueCommentURL ?? self.issueCommentURL,
            contentsURL: contentsURL ?? self.contentsURL,
            compareURL: compareURL ?? self.compareURL,
            mergesURL: mergesURL ?? self.mergesURL,
            archiveURL: archiveURL ?? self.archiveURL,
            downloadsURL: downloadsURL ?? self.downloadsURL,
            issuesURL: issuesURL ?? self.issuesURL,
            pullsURL: pullsURL ?? self.pullsURL,
            milestonesURL: milestonesURL ?? self.milestonesURL,
            notificationsURL: notificationsURL ?? self.notificationsURL,
            labelsURL: labelsURL ?? self.labelsURL,
            releasesURL: releasesURL ?? self.releasesURL,
            deploymentsURL: deploymentsURL ?? self.deploymentsURL,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            pushedAt: pushedAt ?? self.pushedAt,
            gitURL: gitURL ?? self.gitURL,
            sshURL: sshURL ?? self.sshURL,
            cloneURL: cloneURL ?? self.cloneURL,
            svnURL: svnURL ?? self.svnURL,
            homepage: homepage ?? self.homepage,
            size: size ?? self.size,
            stargazersCount: stargazersCount ?? self.stargazersCount,
            watchersCount: watchersCount ?? self.watchersCount,
            language: language ?? self.language,
            hasIssues: hasIssues ?? self.hasIssues,
            hasProjects: hasProjects ?? self.hasProjects,
            hasDownloads: hasDownloads ?? self.hasDownloads,
            hasWiki: hasWiki ?? self.hasWiki,
            hasPages: hasPages ?? self.hasPages,
            forksCount: forksCount ?? self.forksCount,
            mirrorURL: mirrorURL ?? self.mirrorURL,
            archived: archived ?? self.archived,
            disabled: disabled ?? self.disabled,
            openIssuesCount: openIssuesCount ?? self.openIssuesCount,
            license: license ?? self.license,
            forks: forks ?? self.forks,
            openIssues: openIssues ?? self.openIssues,
            watchers: watchers ?? self.watchers,
            defaultBranch: defaultBranch ?? self.defaultBranch,
            score: score ?? self.score
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

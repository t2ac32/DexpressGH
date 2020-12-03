//
//  GHServiceTests.swift
//  DexpressGHTests
//
//  Created by Tracer on 03/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import XCTest
@testable import DexpressGH

class GHServiceTests: XCTestCase {
    var sut: GitHubServiceImpl!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = GitHubServiceImpl()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    /// Test query path creationg from keywords and arguments
    ///
    func testBuildPath() {
        let keywords = ["t2ac32"]
        let qualifiers = [false, true, false, false]
        let finalPath = "user:t2ac32"
        let path = sut.buildPath(from: keywords, qualifiers: qualifiers)
        XCTAssertEqual(path, finalPath)
    }
    /// Test convertion of a template response from a local json file
    ///
    func testFetchReposFromLocal() {
        sut.fetchRepositoriesFromJson { (repositories) in
            guard repositories.items != nil else {
                XCTFail("Error converting a Repositories")
                return
            }
        }
    }
    /// Tests a Repositories object is fetched and usable
    func testFetchReposFromServer() {
        let testQueryTerm = "pokemon"
        sut.fetchRepositories(from: testQueryTerm) { (repositories, _) in
            guard repositories.items != nil else {
                XCTFail("Output has caught no repositories")
                return
            }
            guard repositories.totalCount != nil else {
                XCTFail("Error getting totalCount")
                return
            }
        }
    }
}

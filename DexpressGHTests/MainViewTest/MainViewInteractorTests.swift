//
//  MainViewInteractorTests.swift
//  DexpressGHTests
//
//  Created by Tracer on 03/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import XCTest
@testable import DexpressGH

class MainViewInteractorTests: XCTestCase {
    var sut: MainViewInteractor!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = MainViewInteractor(service: GitHubServiceImpl.shared)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
}

//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieDBTests: XCTestCase {
    var promise = XCTestExpectation()
    override func setUp() {
    }

    func testAPIsuccess() {
        apiTest()
    }
    
    func apiTest(){
        NetworkManager.getPopularMovies(_page: 1) {[weak self] (result) in
            switch result{
            case .success(let popularMovies):
                if !popularMovies.results.isEmpty{
                    self?.promise.fulfill()
                }
            case .failure(let error):
                XCTFail(error)
            }
        }
    }
    
    override func tearDown() {
        
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            apiTest()
        }
    }

}

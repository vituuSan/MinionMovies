//
//  MinionMoviesTests2.swift
//  MinionMoviesTests2
//
//  Created by Vitor Costa on 05/05/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import XCTest
@testable import MinionMovies

class MinionMoviesTests2: XCTestCase {

    let decoder = JSONDecoder()
    var movies: [MovieDB] = []
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIfTheDatabaseIsAddingCorrectly() {
        
        let dbManager = DBManager(config: .inMemory)
        
        for movie in self.movies {
            //Use an in-memory Realm
            dbManager.add(object: movie)
        }
        
        let allObjects = dbManager.retrieveAllObjects(type: MovieDB.self) as! [MovieDB]
        
        XCTAssertEqual(allObjects.count, 4)
        XCTAssertEqual(allObjects[0].title, "Avatar")
        XCTAssertEqual(allObjects[1].title, "Interstellar")
        XCTAssertEqual(allObjects[2].title, "Assassin's Creed")
        XCTAssertEqual(allObjects[3].title, "Rogue One: A Star Wars Story")
        
    }

}

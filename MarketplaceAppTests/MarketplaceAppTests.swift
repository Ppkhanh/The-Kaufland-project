//
//  MarketplaceAppTests.swift
//  MarketplaceAppTests
//
//  Created by Simon Enkel on 28.11.22.
//

import XCTest
@testable import MarketplaceApp


final class MarketplaceAppTests: XCTestCase {

    var sut: StreakLPHandler!

    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = StreakLPHandler()

    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()

    }
    
    
    /**
        Test if loyalty points correspond with level system
     */
    func testPointsToLevelInLevelsystem() {
        
        var ls = Levelsystem(loyaltyPoints: 0)
        
        for i in 0...1002 {
            ls.loyaltyPoints = i
            
            // Expected result
            var result = ls.getLevel()
            
            // Actual result
            var level = ""
            
            if(ls.getPoints(level: result) < 100) {
                level = "Neuling"
            }else if( (ls.getPoints(level: result) >= 100) && (ls.getPoints(level: result) < 200) ) {
                level = "Bronze"
            }else if( (ls.getPoints(level: result) >= 200) && (ls.getPoints(level: result) < 500) ) {
                level = "Silber"
            }else if( (ls.getPoints(level: result) >= 500) && (ls.getPoints(level: result) < 1000) ) {
                level = "Gold"
            }else if(ls.getPoints(level: result) >= 1000) {
                level = "Diamant"
            }
            
            XCTAssertEqual(result, level, "wrong level calculated")
        }
    }
    
    /**
        Test if Milestone days correspond with Milestone loyalty points
     */
    func testIfMilestonesCorrespondWithDays() {
        let sm = StreakMilestones()
        
        for i in 1...101 {
            
            var loyaltyPoints = 0
           
            if(i == 5) {
                loyaltyPoints = 5
            }else if(i == 10) {
                loyaltyPoints = 10
            }else if(i == 15) {
                loyaltyPoints = 20
            }else if(i == 20) {
                loyaltyPoints = 35
            }else if(i == 30) {
                loyaltyPoints = 50
            }else if(i == 40) {
                loyaltyPoints = 50
            }else if(i > 40 && (i % 10 == 0)) {
                loyaltyPoints = 50
            }else if(i > 40 && (i % 10 != 0)) {
                loyaltyPoints = 0
            }
            
            XCTAssertEqual(sm.checkForMilestone(streak: i), loyaltyPoints, "wrong milestone calculation")
        }
        
    }

}

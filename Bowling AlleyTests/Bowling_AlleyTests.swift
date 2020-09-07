//
//  Bowling_AlleyTests.swift
//  Bowling AlleyTests
//
//  Created by Marcel Mierzejewski on 05/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import XCTest
@testable import Bowling_Alley

class Bowling_AlleyTests: XCTestCase {
    
    var player: Player!

    override func setUp() {
        super.setUp()
        player = Player(name: "Marcel Mierzejewski knows TDD")
    }
    
    func test_init_Player() throws {
        XCTAssertEqual(player.name, "Marcel Mierzejewski knows TDD")
        XCTAssertEqual(player.currentRoll, 0)
        XCTAssertEqual(player.rolls.count, 21)
    }

    func test_rolling_WithoutKnockingPins() throws {
        massRoll(knockedPins: 0, times: 20)

        let score = player.getScore()
        XCTAssertEqual(score, 0)
    }
    
    func test_rolling_ThreePinsEachShot() throws {
        massRoll(knockedPins: 3, times: 8)
        
        let score = player.getScore()
        XCTAssertEqual(score, 24)
    }
    
    func test_rolling_SpareBonus() throws {
        // First frame
        player.addRoll(pinsKnocked: 1)
        player.addRoll(pinsKnocked: 6)

        // Second frame
        rollSpare()

        // Third frame -  needed for spare bonus calculation
        player.addRoll(pinsKnocked: 5)
        player.addRoll(pinsKnocked: 0)

        let score = player.getScore()
        XCTAssertEqual(score, 7 + 15 + 5)
    }
    
    func test_rolling_StrikeBonus() throws {
        // First frame
        player.addRoll(pinsKnocked: 1)
        player.addRoll(pinsKnocked: 6)

        // Second frame
        rollStrike()

        // Third frame -  needed for spare bonus calculation
        player.addRoll(pinsKnocked: 5)
        player.addRoll(pinsKnocked: 3)

        let score = player.getScore()
        XCTAssertEqual(score, 7 + 18 + 8)
    }
    
    func test_rolling_UnsettledStrikeBonus() throws {
        // First frame
        player.addRoll(pinsKnocked: 1)
        player.addRoll(pinsKnocked: 6)

        // Second frame
        rollStrike()
        
        // Third frame not finished
        player.addRoll(pinsKnocked: 2)

        let score = player.getScore()
        XCTAssertEqual(score, 7 + 12 + 2)
    }
    
    func test_rolling_PerfectGame() throws {
        massRoll(knockedPins: 10, times: 12)
        
        let score = player.getScore()
        XCTAssertEqual(score, 300)
    }
}

// MARK: - Helper test functions

extension Bowling_AlleyTests {
    fileprivate func massRoll(knockedPins: Int, times: Int) {
        for _ in 1...times {
            player.addRoll(pinsKnocked: knockedPins)
        }
    }
    
    fileprivate func rollSpare() {
        player.addRoll(pinsKnocked: 5)
        player.addRoll(pinsKnocked: 5)
    }
    
    fileprivate func rollStrike() {
        player.addRoll(pinsKnocked: 10)
    }
}

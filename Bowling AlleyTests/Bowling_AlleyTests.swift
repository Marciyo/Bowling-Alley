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
        XCTAssertTrue(player.pinsKnockedByRollRecord.isEmpty)
        XCTAssertTrue(player.frameRecord.isEmpty)

        XCTAssertEqual(player.name, "Marcel Mierzejewski knows TDD")
    }

    func test_rolling_WithoutKnockingPins() throws {
        massRoll(knockedPins: 0, times: 8)

        XCTAssertFalse(player.pinsKnockedByRollRecord.isEmpty)
        XCTAssertFalse(player.frameRecord.isEmpty)

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
        player.addRoll(pinsKnocked: 6)
        player.addRoll(pinsKnocked: 4)

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
        player.addRoll(pinsKnocked: 10)
        
        // Third frame -  needed for spare bonus calculation
        player.addRoll(pinsKnocked: 5)
        player.addRoll(pinsKnocked: 3)

        let score = player.getScore()
        XCTAssertEqual(score, 7 + 18 + 8)
    }
    
    func test_init_Frame() throws {
        let normalFrame = Frame(firstShot: 4, secondShot: 3)
        
        XCTAssertFalse(normalFrame.isSpare)
        XCTAssertFalse(normalFrame.isStrike)
        XCTAssertTrue(normalFrame.isFrameCompleted)

        let incompleteFrame = Frame(firstShot: 1)
        XCTAssertFalse(incompleteFrame.isSpare)
        XCTAssertFalse(incompleteFrame.isStrike)
        XCTAssertFalse(incompleteFrame.isFrameCompleted)
        
        let strikeFrame = Frame(firstShot: 10)
        XCTAssertFalse(strikeFrame.isSpare)
        XCTAssertTrue(strikeFrame.isStrike)
        XCTAssertTrue(strikeFrame.isFrameCompleted)
        
        let spareFrame = Frame(firstShot: 4, secondShot: 6)
        XCTAssertFalse(spareFrame.isStrike)
        XCTAssertTrue(spareFrame.isSpare)
        XCTAssertTrue(spareFrame.isFrameCompleted)
    }
}

extension Bowling_AlleyTests {
    fileprivate func massRoll(knockedPins: Int, times: Int) {
        for _ in 1...times {
            player.addRoll(pinsKnocked: knockedPins)
        }
    }
}

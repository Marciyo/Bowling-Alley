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

    func test_init_Player() throws {
        let player = Player(name: "Marcel")
        
        XCTAssertTrue(player.pinsKnockedByThrowRecord.isEmpty)
        XCTAssertTrue(player.frameRecord.isEmpty)

        XCTAssertEqual(player.name, "Marcel")
    }

    func test_throwingWithoutKnockingPins() throws {
        var player = Player(name: "Mierzejewski")
        
        player.addThrow(pinsKnocked: 0)
        player.addThrow(pinsKnocked: 0)
        player.addThrow(pinsKnocked: 0)
        player.addThrow(pinsKnocked: 0)
        player.addThrow(pinsKnocked: 0)
        player.addThrow(pinsKnocked: 0)

        XCTAssertFalse(player.pinsKnockedByThrowRecord.isEmpty)
        XCTAssertFalse(player.frameRecord.isEmpty)

        let score = player.getScore()
        XCTAssertEqual(score, 0)
    }
    
    
}

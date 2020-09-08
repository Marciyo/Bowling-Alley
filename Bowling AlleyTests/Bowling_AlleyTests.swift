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

        // Third frame - needed for spare bonus calculation
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

        // Third frame - needed for spare bonus calculation
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
    
    func test_frameGeneration_NoPinsKnocked() throws {
        massRoll(knockedPins: 0, times: 20)
        
        let frames = player.getFrames()
        XCTAssertEqual(frames.count, 10)
        XCTAssertEqual(frames.first?.firstShot, 0)
        XCTAssertEqual(frames.first?.secondShot, 0)
        
        let tenthFrame = frames[9] as? TenthFrame
        XCTAssertNotNil(tenthFrame)
        XCTAssertEqual(tenthFrame?.firstShot, 0)
        XCTAssertEqual(tenthFrame?.secondShot, 0)
        XCTAssertNil(tenthFrame?.thirdShot)
    }
    
    func test_frameGeneration_AllPinsKnocked() throws {
        massRoll(knockedPins: 10, times: 12)
        
        let frames = player.getFrames()
        XCTAssertEqual(frames.count, 10)
        
        XCTAssertEqual(frames.first?.firstShot, 10)
        XCTAssertNil(frames.first?.secondShot)
        
        let tenthFrame = frames[9] as? TenthFrame
        XCTAssertNotNil(tenthFrame)
        XCTAssertEqual(tenthFrame?.firstShot, 10)
        XCTAssertEqual(tenthFrame?.secondShot, 10)
        XCTAssertEqual(tenthFrame?.thirdShot, 10)
    }
    
    func test_frameGeneration_AllFramesSpares() throws {
        massRoll(knockedPins: 5, times: 21)
        
        let frames = player.getFrames()
        XCTAssertEqual(frames.count, 10)
        
        let tenthFrame = frames[9] as? TenthFrame
        XCTAssertNotNil(tenthFrame)
        XCTAssertEqual(tenthFrame?.firstShot, 5)
        XCTAssertEqual(tenthFrame?.secondShot, 5)
        XCTAssertEqual(tenthFrame?.thirdShot, 5)
    }
    
    func test_frameGeneration_GameNotFinishedYet() throws {
        massRoll(knockedPins: 2, times: 10)
        
        let frames = player.getFrames()
        XCTAssertEqual(frames.count, 5)
        XCTAssertTrue(frames[4].isFrameCompleted)
    }
    
    func test_frameGeneration_FrameNotFinishedYet() throws {
        massRoll(knockedPins: 2, times: 11)
        
        let frames = player.getFrames()
        XCTAssertEqual(frames.count, 6)
        XCTAssertFalse(frames[5].isFrameCompleted)
    }
    
    func test_init_Frame() throws {
        let normalFrame = RegularFrame(firstShot: 4, secondShot: 3)
        XCTAssertFalse(normalFrame.isSpare)
        XCTAssertFalse(normalFrame.isStrike)
        XCTAssertTrue(normalFrame.isFrameCompleted)

        let incompleteFrame = RegularFrame(firstShot: 1)
        XCTAssertFalse(incompleteFrame.isSpare)
        XCTAssertFalse(incompleteFrame.isStrike)
        XCTAssertFalse(incompleteFrame.isFrameCompleted)
        
        let strikeFrame = RegularFrame(firstShot: 10)
        XCTAssertFalse(strikeFrame.isSpare)
        XCTAssertTrue(strikeFrame.isStrike)
        XCTAssertTrue(strikeFrame.isFrameCompleted)
        
        let spareFrame = RegularFrame(firstShot: 4, secondShot: 6)
        XCTAssertFalse(spareFrame.isStrike)
        XCTAssertTrue(spareFrame.isSpare)
        XCTAssertTrue(spareFrame.isFrameCompleted)
        
        let incompleteTenthFrame = TenthFrame(firstShot: 6, secondShot: nil, thirdShot: nil)
        XCTAssertFalse(incompleteTenthFrame.isFrameCompleted)
        
        let completeTenthFrame = TenthFrame(firstShot: 6, secondShot: 2, thirdShot: nil)
        XCTAssertTrue(completeTenthFrame.isFrameCompleted)

        let completeSpareTenthFrame = TenthFrame(firstShot: 6, secondShot: 4, thirdShot: 5)
        XCTAssertTrue(completeSpareTenthFrame.isFrameCompleted)

        let incompleteSpareTenthFrame = TenthFrame(firstShot: 6, secondShot: 4, thirdShot: nil)
        XCTAssertFalse(incompleteSpareTenthFrame.isFrameCompleted)

        let incompleteStrikeTenthFrame = TenthFrame(firstShot: 10, secondShot: 4, thirdShot: nil)
        XCTAssertFalse(incompleteStrikeTenthFrame.isFrameCompleted)
        
        let completeStrikeTenthFrame = TenthFrame(firstShot: 10, secondShot: 10, thirdShot: 5)
        XCTAssertTrue(completeStrikeTenthFrame.isFrameCompleted)
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

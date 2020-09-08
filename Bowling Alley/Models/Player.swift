//
//  Player.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 07/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI
import Combine

struct Player: Codable {
    var name: String
    var rolls = [Int?](repeating: nil, count: 21)
    var currentRoll = 0
}

extension Player {
    mutating func addRoll(pinsKnocked: Int) {
        rolls[currentRoll] = pinsKnocked
        currentRoll += 1
    }
    
    func getScore() -> Int {
        var score = 0
        var roll = 0
        
        for _ in 1...10 {
            if isStrike(roll) {
                score += 10 + strikeBonus(roll)
                roll += 1
            } else if isSpare(roll) {
                score += 10 + spareBonus(roll)
                roll += 2
            } else {
                score += (rolls[roll] ?? 0) + (rolls[roll + 1] ?? 0)
                roll += 2
            }
        }
        
        return score
    }
}

extension Player {
    func getFrames() -> [Frame] {
        var frames: [Frame] = []
        var roll = 0

        for _ in 1...9 {
            if isStrike(roll) {
                frames.append(RegularFrame(firstShot: 10))
                roll += 1
            } else {
                let frame = RegularFrame(firstShot: rolls[roll], secondShot: rolls[roll + 1])
                frames.append(frame)
                roll += 2
            }
            
            if roll >= currentRoll {
                return frames
            }
        }
        
        if isStrike(roll) || isSpare(roll) {
            frames.append(TenthFrame(firstShot: rolls[roll], secondShot: rolls[roll + 1], thirdShot: rolls[roll + 2]))
        } else {
            frames.append(TenthFrame(firstShot: rolls[roll], secondShot: rolls[roll + 1], thirdShot: nil))
        }

        return frames
    }
}

extension Player {
    private func isStrike(_ roll: Int) -> Bool {
        rolls[roll] == 10
    }
    
    private func isSpare(_ roll: Int) -> Bool {
        (rolls[roll] ?? 0) + (rolls[roll + 1] ?? 0) == 10
    }
    
    private func strikeBonus(_ roll: Int) -> Int {
        (rolls[roll + 1] ?? 0) + (rolls[roll + 2] ?? 0)
    }
    
    private func spareBonus(_ roll: Int) -> Int {
        rolls[roll + 2] ?? 0
    }
}

//
//  ScoreCalculation.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 08/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

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
    func isStrike(_ roll: Int) -> Bool {
        rolls[roll] == 10
    }
    
    func isSpare(_ roll: Int) -> Bool {
        (rolls[roll] ?? 0) + (rolls[roll + 1] ?? 0) == 10
    }
    
    func strikeBonus(_ roll: Int) -> Int {
        (rolls[roll + 1] ?? 0) + (rolls[roll + 2] ?? 0)
    }
    
    func spareBonus(_ roll: Int) -> Int {
        rolls[roll + 2] ?? 0
    }
}

//
//  FrameCalculation.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 08/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

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

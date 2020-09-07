//
//  LeaderboardView.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 05/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        Text("Leaderboard")
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}

class GameState: ObservableObject {
    @Published var players: [Player] = [Player(name: "Marcel"), Player(name: "Klau")]
}

struct GameRecord: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    let date: Date
    let players: [Player]
}

extension GameRecord {
    var numberOfPlayers: Int {
        players.count
    }
}

struct Player: Codable {
    var name: String
    var pinsKnockedByRollRecord: [Int] = []
    var frameRecord: [Frame] = [] {
        didSet {
            print("Updated frameRecord: \(frameRecord)")
        }
    }
}

extension Player {
    func getScore() -> Int {
        var roll = 0
        var spareBonus = 0
        var strikeBonus = 0
        
        for frame in frameRecord.enumerated() {
            if frame.element.isFrameCompleted {
                roll += (frame.element.firstShot ?? 0) + (frame.element.secondShot ?? 0)
            }
            
            if frame.element.isStrike {
                spareBonus += 0
            } else if frame.element.isSpare {
                strikeBonus += 0
            }
        }
        
        return roll + spareBonus + strikeBonus
    }
    
    mutating func addRoll(pinsKnocked: Int) {
        pinsKnockedByRollRecord.append(pinsKnocked)
        
        guard let lastFrame = frameRecord.last else {
            // This is first frame
            
            if pinsKnockedByRollRecord.count % 2 != 0 {
                //First throw
                if pinsKnocked == 10 {
                    // Strike
                    frameRecord.append(Frame(firstShot: 10)) // <-- Adding frame
                }
                //Just keep throwing?
            } else {
                //Second throw
                let firstThrow = pinsKnockedByRollRecord[pinsKnockedByRollRecord.count - 2]
                let secondThrow = pinsKnockedByRollRecord[pinsKnockedByRollRecord.count - 1]
                
                frameRecord.append(Frame(firstShot: firstThrow, secondShot: secondThrow)) // <-- Adding frame
            }
            
            return
        }
        
        if lastFrame.isStrike {
            
        }
        
//
//        if pinsKnockedByRollRecord.count % 2 != 0 {
//            //First throw
//            if pinsKnocked == 10 {
//                // Strike
//                frameRecord.append(Frame(firstShot: 10))
//            }
//            //Just keep throwing?
//        } else {
//            //Second throw
//            guard let lastThrow = pinsKnockedByRollRecord.last else {
//                assertionFailure("There should be last throw")
//                return
//            }
//
//            if lastThrow == 10 {
//                //It was strike a turn before. Check frame
//            }
//
//
//            let firstThrow = pinsKnockedByRollRecord[pinsKnockedByRollRecord.count - 2]
//            let secondThrow = pinsKnockedByRollRecord[pinsKnockedByRollRecord.count - 1]
//
//            frameRecord.append(Frame(firstShot: firstThrow, secondShot: secondThrow))
//        }
        
        
        if frameRecord.count == 10  {
            assertionFailure("End the game")
            // End the game
            // We are on the last frame and all score has been calculated
        }
    }
}

struct Frame: Codable {
    var firstShot: Int?
    var secondShot: Int?
    var thirdShot: Int?
}

extension Frame {
    var isSpare: Bool {
        if isStrike { return false }
        return (firstShot ?? 0) + (secondShot ?? 0) == 10
    }
    
    var isStrike: Bool {
        (firstShot ?? 0) == 10
    }
    
    var isFrameCompleted: Bool {
        firstShot != nil && secondShot != nil || isStrike
    }
}


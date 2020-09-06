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
    var pinsKnockedByThrowRecord: [Int] = []
    var frameRecord: [Frame] = [] {
        didSet {
            print("Updated frameRecord: \(frameRecord)")
        }
    }
}

extension Player {
    func getScore() -> Int {
        return 0
    }
    
    mutating func addThrow(pinsKnocked: Int) {
        pinsKnockedByThrowRecord.append(pinsKnocked)
        
        
        if pinsKnockedByThrowRecord.count % 2 != 0 {
            //First throw
            if pinsKnocked == 10 {
                // Strike
                frameRecord.append(Frame(firstShot: 10))
            }
            //Just keep throwing?
        } else {
            //Second throw
            guard let lastThrow = pinsKnockedByThrowRecord.last else {
                assertionFailure("There should be last throw")
                return
            }
            
            if lastThrow == 10 {
                //It was strike a turn before. Check frame
            }
            
            
            let firstThrow = pinsKnockedByThrowRecord[pinsKnockedByThrowRecord.count - 2]
            let secondThrow = pinsKnockedByThrowRecord[pinsKnockedByThrowRecord.count - 1]
            
            frameRecord.append(Frame(firstShot: firstThrow, secondShot: secondThrow))
        }
        
        
        if frameRecord.count == 10  {
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
    var isFrameCompleted: Bool {
        firstShot != nil && secondShot != nil
    }
}


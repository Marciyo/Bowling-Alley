//
//  Game.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 07/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Combine
import SwiftUI

final class GameState: ObservableObject {
    public static let shared = GameState()
    
    init() {
        self.players.append(contentsOf: [Player(name: "Marcel"), Player(name: "Not Marcel")])
    }

    @Published var players: [Player] = []
}

extension GameState {
    func getFrames(for playerName: String) -> [RegularFrame] {
        guard let player = players.first(where: { $0.name == playerName })
            else {
                assertionFailure("error")
                return []
        }
        return player.getFrames() as! [RegularFrame]
    }
    
    func getCurrentScore(for playerName: String) -> Int {
        guard let player = players.first(where: { $0.name == playerName })
            else {
                assertionFailure("error")
                return 0
        }
        return player.getScore()
    }
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

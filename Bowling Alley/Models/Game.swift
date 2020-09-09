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
        self.players.append(contentsOf: [Player(name: "Marcel"), Player(name: "Klau")])
    }

    @Published var players: [Player] = []
    
    
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

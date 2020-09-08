//
//  Game.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 07/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Combine
import SwiftUI

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

protocol Frame {
    var firstShot: Int? { get set }
    var secondShot: Int? { get set }
}

struct RegularFrame: Frame, Codable {
    var firstShot: Int?
    var secondShot: Int?
}

struct TenthFrame: Frame, Codable {
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


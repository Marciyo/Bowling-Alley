//
//  Player.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 07/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

struct Player: Codable {
    var name: String
    var rolls = [Int?](repeating: nil, count: 21)
    var currentRoll = 0
}

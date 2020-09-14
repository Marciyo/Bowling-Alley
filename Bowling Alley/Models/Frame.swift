//
//  Frame.swift
//  Bowling Alley
//
//  Created by Marcel Mierzejewski on 08/09/2020.
//  Copyright © 2020 Marcel Mierzejewski. All rights reserved.
//

import Foundation

protocol Frame {
    var firstShot: Int? { get set }
    var secondShot: Int? { get set }
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

struct RegularFrame: Frame, Codable, Hashable {
    var firstShot: Int?
    var secondShot: Int?
}

struct TenthFrame: Frame, Codable, Hashable {
    var firstShot: Int?
    var secondShot: Int?
    var thirdShot: Int?
}

extension TenthFrame {
    var isFrameCompleted: Bool {
        if firstShot == 10 || (firstShot ?? 0) + (secondShot ?? 0) == 10 {
            return thirdShot != nil
        }
        
        return firstShot != nil && secondShot != nil
    }
}

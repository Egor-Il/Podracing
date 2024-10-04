//
//  LeaderboardManager.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/24/24.
//

import Foundation

final class LeaderboardManager {
    
    let raceRecord: String
    let playerName: String
    let recordDate: String
    
    init(raceRecord: String, playerName: String, recordDate: String) {
        self.raceRecord = raceRecord
        self.playerName = playerName
        self.recordDate = recordDate
        
    }
}

//
//  LeaderboardData.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/25/24.
//

import Foundation

protocol LeaderboardDataProtocol {
    func addRecord(record: String, playerName: String, date: String)
    
    func clearRecords()
}

final class LeaderboardData: LeaderboardDataProtocol {
    
    private var LeaderboardDataArray: [(record: String, player: String, date: String)] = []
    
    func clearRecords() {
        LeaderboardDataArray.removeAll()
    }
    func addRecord(record: String, playerName: String, date: String) {
        LeaderboardDataArray.append((record, playerName, date))
    }
    func getRecords() -> [(record: String, player: String, date: String)] {
        return LeaderboardDataArray
    }
}

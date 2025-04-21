//
//  LeaderboardManager.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/24/24.
//

import Foundation

struct LeaderboardEntry: Codable {
    let record: Int
    let player: String
    let date: String
}

final class LeaderboardManager {
    
    static let shared = LeaderboardManager()
    private var leaderboardEntries: [LeaderboardEntry] = []
    private let userDefaultsKey = LeaderboardConstants.userDefaults.userDefaultsKey
    
    private init() {
        loadFromStorage()
    }
    
    func addRecord(record: Int, playerName: String, date: String) {
        let entryResult = LeaderboardEntry(record: record, player: playerName, date: date)
        let recordExist = leaderboardEntries.contains { $0.record == entryResult.record }
        if recordExist || entryResult.record == 0 {
            return
        } else {
            leaderboardEntries.append(entryResult)
            leaderboardEntries.sort { $0.record > $1.record }
            saveToStorage()
        }
    }
    
    func clearRecord() {
        leaderboardEntries.removeAll()
        saveToStorage()
    }
    
    func getRecord() -> [LeaderboardEntry] {
        return leaderboardEntries
    }
    
    private func saveToStorage() {
        if let data = try? JSONEncoder().encode(leaderboardEntries) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
    private func loadFromStorage() {
        if let data = UserDefaults.standard.value([LeaderboardEntry].self, forKey: userDefaultsKey) {
            leaderboardEntries = data
        }
    }
}

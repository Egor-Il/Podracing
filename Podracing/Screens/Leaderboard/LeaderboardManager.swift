//
//  LeaderboardManager.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/24/24.
//

import Foundation

struct LeaderboardEntry: Codable {
    let record: String
    let player: String
    let date: String
}


final class LeaderboardManager {
    
    static let shared = LeaderboardManager()
    
    private var leaderboardEntries: [LeaderboardEntry] = []
    
    private let userDefaultsKey = "LeaderboardEntries"
    
    private init() {
        loadFromStorage()
    }
    
    func addRecord(record: String, playerName: String, date: String) {
        let entry = LeaderboardEntry(record: record, player: playerName, date: date)
        leaderboardEntries.append(entry)
        saveToStorage()
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

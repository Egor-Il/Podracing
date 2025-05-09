//
//  SavedSettings.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/9/25.
//

import Foundation

// MARK: - Saving object

struct SavedSettings: Codable {
    let selectedPod: String
    let barrierName: String
    let playerName: String
    let difficultyLevel: String
    let difficultyLevelValue: Double
    let difficultySliderValue: Float
}

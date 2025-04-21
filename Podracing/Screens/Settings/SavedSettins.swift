//
//  SavedSettins.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/4/25.
//

import Foundation

// MARK: - Saving object

final class SavedSettins: Codable {
    
    let selectedPod: String
    let barrierName: String
    let playerName: String
    let difficultyLevel: String
    let difficultyLevelValue: Double
    let difficultySliderValue: Float
    
    init(selectedPod: String, barrierName: String, playerName: String, difficultyLevel: String, difficultyLevelValue: Double, difficultySliderValue: Float) {
        
        self.selectedPod = selectedPod
        self.barrierName = barrierName
        self.playerName = playerName
        self.difficultyLevel = difficultyLevel
        self.difficultyLevelValue = difficultyLevelValue
        self.difficultySliderValue = difficultySliderValue
    }
    
}

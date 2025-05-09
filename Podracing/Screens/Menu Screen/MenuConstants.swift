//
//  MenuConstants.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/19/25.
//

import Foundation
// MARK: - Constatnt name and value for setup Menu screen 
final class MenuConstants {
    
    enum GameLabel {
        static let title = "Podracing"
    }
    
    enum Strings {
        static let podracing = "Podracing"
        static let play = "play"
        static let leaderboard = "Leaderboard"
        static let setting = "Setting"
        static let menuScreenPic = "menuScreen"
    }
    
    enum Layout {
        static let gameNameLabelTopOffset: CGFloat = 70
        static let buttonsOffset: CGFloat = 40
        static let buttonsContainerHeight: CGFloat = 150
    }
   
    enum Font {
        static let fontName = "Starjedi"
        static let gameLabelSize: CGFloat = 45
        static let buttonsSize: CGFloat = 20
    }
}

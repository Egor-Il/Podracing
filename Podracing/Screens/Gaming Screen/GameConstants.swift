//
//  GameConstants.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/22/25.
//

import Foundation

final class GameConstants {
    
    enum Font {
        static let fontName = "Starjedi"
        static let buttonBackFontSize: CGFloat = 18
        static let scoreLableFontSize: CGFloat = 18
        static let countdownLabelFontSize: CGFloat = 10
    }
    
    enum Value {
        static let score = 0
        static let nextScoreThreshold = 10
    }
    
    enum Layout {
        static let backButtonOffset: CGFloat = 40
        static let scoreLableOffsetTop: CGFloat = 40
        static let scoreLableOffsetRight: CGFloat = 60
    }
    
    enum Strings {
        static let countdownLabelGo = "go"
        static let backAlertTitle = "Are you sure you want to exit the game"
        static let backAlertMessage = "all progress will be lost"
        static let backAlertTitleExit = "exit"
        static let backAlertTitleCancel = "cancel"
        static let defaultPlayerName = "skywalker"
        static let dateFormat = "dd.MM.yy"
        static let gameOverAlertTitle = "game over"
//        static let gameOverAlertMessage = "Yor record is \(score)"
        static let gameOverExitButton = "exit"
        static let gameOverRestartButton = "restart"
        static let explosionAnimationPic = "explosionOne"
    }
    
}

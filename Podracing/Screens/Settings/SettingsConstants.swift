//
//  SettingsConstants.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/20/25.
//

import Foundation

final class SettingsConstants {
    
    enum Strings {
        static let back = "back"
        static let settingsPicName = "settingImage"
        static let leftArrow = "arrowLeft"
        static let rightArrow = "arrowRight"
        static let selectedPod = "selected pod"
        static let stoneOne = "stoneOne"
        static let selectedBarrier = "selected barrier"
        static let player = "Player"
        static let playerName = "player name"
        static let difficultyLevel = "Difficulty Level"
        static let medium = "medium"
        static let defaultName = "Skywalker"
        static let defaultPod = "mainPod"
    }
    
    enum Layout {
        static let buttonsOffset: CGFloat = 40
        static let buttonsHeight: CGFloat = 50
        static let sittingsContainerLeftRightOffset: CGFloat = 10
        static let sittingsContainerBottomOffset: CGFloat = 30
        static let choiceRightLeftButtonOffset: CGFloat = 5
        static let podLabelTopOffset: CGFloat = 10
        static let podLabelHeight: CGFloat = 20
        static let mainPodImageTopBottomOffset: CGFloat = 5
        static let barrierLabelHeight: CGFloat = 20
        static let barrierImageTopBottomOffset: CGFloat = 5
        static let userNameLeftRightOffset: CGFloat = 5
        static let difficultySliderLeftRightOffset: CGFloat = 20
        static let difficultyLevelLabelBottomOffset: CGFloat = 5
        static let keyboardWillShowSittings: CGFloat = 30
        static let keyboardWillHideTop: CGFloat = 10
        static let keyboardWillHideBottom: CGFloat = 30
        static let barrierLabelTopOffset: CGFloat = 5
        static let sittingsContainerCornerRadius: CGFloat = 30
        static let keyboardWillShowOffsetBetweenKeyboardAndTextfield: CGFloat = 5
        static let multiplierForSettingsContainer = 0.3
        static let multiplierForUserNameContainer = 0.2
        static let multiplierForUserName = 1.25
    }
    
    enum Value {
        static let sittingsContainerAlphaComponent:CGFloat = 0.8
        static let buttonsSize: CGFloat = 20
        static let difficultySliderMinValue: Float = 0
        static let difficultySliderMidValue: Float = 1
        static let difficultySliderMaxValue: Float = 2
        static let easySpeed: Double = 2
        static let mediumSpeed: Double = 3
        static let hardSpeed: Double = 4
    }
    
    enum Font {
        static let fontName = "Starjedi"
        static let buttonsSize: CGFloat = 20
    }
    
    enum userDefaults {
        static let playerSettings = "player"
    }
}

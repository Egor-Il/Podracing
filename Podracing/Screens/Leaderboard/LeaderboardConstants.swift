//
//  LeaderboardConstants.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/20/25.
//

import Foundation

final class LeaderboardConstants {
    
    enum Strings {
        static let back = "back"
        static let clear = "clear"
        static let leaderboardPicName = "leaderBoard"
        static let record = "record"
        static let name = "name"
        static let date = "date"
    }
    
    enum Font {
        static let fontName = "Starjedi"
        static let buttonBackFontSize: CGFloat = 18
        static let buttonClearFontSize: CGFloat = 18
        static let headerFontSize: CGFloat = 16
        static let recordFontSize: CGFloat = 15
    }
    
    enum Value {
        static let cornerRadius: CGFloat = 20
    }
    
    enum Layout {
        static let buttonsOffset: CGFloat = 40
        static let headerTopOffset: CGFloat = 15
        static let headerLeftRightOffset: CGFloat = 30
        static let headerHeight: CGFloat = 50
        static let headerNameOffset: CGFloat = 5
        static let scoreLabelLeftRightOffset: CGFloat = 30
        static let playerNameOffset: CGFloat = 5
    }
    
    enum userDefaults {
        static let userDefaultsKey = "LeaderboardEntries"
    }
    
}

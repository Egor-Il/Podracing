//
//  LeaderboardViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

class LeaderboardViewController: UIViewController {
    
    private let leaderboardImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    private let buttonBack: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Buttons.buttonBackLable, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configuratLeaderBoardUI()
        view.backgroundColor = .lightGray
    }
    private func configuratLeaderBoardUI() {
        view.addSubview(leaderboardImage)
        view.addSubview(buttonBack)
        let  boardImage = UIImage(named: Images.leaderboard)
        leaderboardImage.image = boardImage
        leaderboardImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        buttonBack.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonBackOffSet)
        }
        let backfromBoardAction = UIAction { _ in
            self.backButtonPressed()
        }
        buttonBack.addAction(backfromBoardAction, for: .touchUpInside)
    }
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}

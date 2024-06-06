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
    private let leaderboardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.alpha = 0.5
        view.layer.cornerRadius = 20
        return view
    }()
     var leaderboardText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: 20)
        label.textColor = .black
         
        return label
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
        view.addSubview(leaderboardView)
        leaderboardView.addSubview(leaderboardText)
        leaderboardImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        buttonBack.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonOffSet)
        }
        leaderboardView.snp.makeConstraints { make in
            make.top.equalTo(buttonBack.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(300)
        }
        leaderboardText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        let backfromBoardAction = UIAction { _ in
            self.backButtonPressed()
        }
        buttonBack.addAction(backfromBoardAction, for: .touchUpInside)
        recordTime()
    }
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    func recordTime() {
        let savedDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy, HH:mm"
        let savedRaceDate = formatter.string(from: savedDate)
        print(savedRaceDate)
       leaderboardText.text = "1 - \(savedRaceDate)"
    }
}

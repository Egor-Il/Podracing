//
//  ViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/14/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // MARK: - Property
    
    private let menuScreen = UIImageView() 
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.fontName, size: Font.gameLabelFont )
        label.textColor = .white
        label.text = Labels.gameName
        return label
    }()
    private let buttonsConteiner = UIView()
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Buttons.playButtonLabel, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonFont)
        return button
    }()
    private let boardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Buttons.boardButtonLabel, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonFont)
        return button
    }()
    private let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Buttons.settingButtonLabel, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonFont)
        return button
    }()
    // MARK: - life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configuratMenuUI()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func configuratMenuUI() {
        view.addSubview(menuScreen)
        view.addSubview(gameNameLabel)
        buttonsConteiner.addSubview(playButton)
        buttonsConteiner.addSubview(boardButton)
        buttonsConteiner.addSubview(settingButton)
        view.addSubview(buttonsConteiner)
      
        let menuImage = UIImage(named: Images.menu)
        menuScreen.image = menuImage
        menuScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        gameNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Labels.gameNameLabelOffSet)
        }
        buttonsConteiner.snp.makeConstraints { make in
            make.top.equalTo(gameNameLabel.snp.bottom).offset(Buttons.buttonOffSet)
            make.left.right.equalToSuperview()
            make.height.equalTo(Buttons.buttonsConteinerHeight)
        }
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        boardButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(playButton.snp.bottom)
        }
        settingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(boardButton.snp.bottom)
        }
        let actionPlay = UIAction { _ in
            self.playPressed()
        }
        let actionSettings = UIAction { _ in
            self.settingsPressed()
        }
        let actionLeaderboard = UIAction { _ in
            self.leaderboardPressed()
        }
        playButton.addAction(actionPlay, for: .touchUpInside)
        settingButton.addAction(actionSettings, for: .touchUpInside)
        boardButton.addAction(actionLeaderboard, for: .touchUpInside)
    }
    private func playPressed() {
        let controller = GameViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    private func settingsPressed() {
        let controller = SettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    private func leaderboardPressed() {
        let controller = LeaderboardViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}


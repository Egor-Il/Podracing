//
//  MenuViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/3/25.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
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
    private let createButton: (String) -> UIButton = { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonFont)
        return button
    }
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuUI()
    }
    
    private func configureMenuUI() {
        view.addSubview(menuScreen)
        view.addSubview(gameNameLabel)
        buttonsConteiner.addSubview(playButton)
        buttonsConteiner.addSubview(boardButton)
        buttonsConteiner.addSubview(settingButton)
        view.addSubview(buttonsConteiner)
        setupConstraints()
        let menuImage = UIImage(named: Images.menu)
        menuScreen.image = menuImage
        
        let playButtonAction = UIAction { _ in
            self.playPressed()
        }
        let settingsButtonAction = UIAction { _ in
            self.settingsPressed()
        }
        let leaderboardButtonAction = UIAction { _ in
            self.leaderboardPressed()
        }
        playButton.addAction(playButtonAction, for: .touchUpInside)
        settingButton.addAction(settingsButtonAction, for: .touchUpInside)
        boardButton.addAction(leaderboardButtonAction, for: .touchUpInside)
    }
    // MARK: - Actions
    private func setupConstraints() {
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

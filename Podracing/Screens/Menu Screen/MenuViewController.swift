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
        label.font = UIFont(name: MenuConstants.Font.fontName, size: MenuConstants.Font.gameLabelSize )
        label.textColor = .white
        label.text = MenuConstants.Strings.podracing
        return label
    }()
    
    private let buttonsConteiner = UIView()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(MenuConstants.Strings.play, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: MenuConstants.Font.fontName, size: MenuConstants.Font.buttonsSize)
        return button
    }()
    
    private let boardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(MenuConstants.Strings.leaderboard, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: MenuConstants.Font.fontName, size: MenuConstants.Font.buttonsSize)
        return button
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(MenuConstants.Strings.setting, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: MenuConstants.Font.fontName, size: MenuConstants.Font.buttonsSize)
        return button
    }()
    //    private let createButton: (String) -> UIButton = { buttonTitle in
    //        let button = UIButton(type: .system)
    //        button.setTitle(buttonTitle, for: .normal)
    //        button.setTitleColor(.green, for: .normal)
    //        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonFont)
    //        return button
    //    }
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuUI()
    }
    
    // MARK: - Func Actions
    private func configureMenuUI() {
        view.addSubview(menuScreen)
        view.addSubview(gameNameLabel)
        view.addSubview(buttonsConteiner)
        buttonsConteiner.addSubview(playButton)
        buttonsConteiner.addSubview(boardButton)
        buttonsConteiner.addSubview(settingButton)
        setupConstraints()
        
        let menuImage = UIImage(named: MenuConstants.Strings.menuScreenPic)
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
    
    private func setupConstraints() {
        menuScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        gameNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(MenuConstants.Layout.gameNameLabelTopOffset)
        }
        buttonsConteiner.snp.makeConstraints { make in
            make.top.equalTo(gameNameLabel.snp.bottom).offset(MenuConstants.Layout.buttonsOffset)
            make.left.right.equalToSuperview()
            make.height.equalTo(MenuConstants.Layout.buttonsConteinerHeight)
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

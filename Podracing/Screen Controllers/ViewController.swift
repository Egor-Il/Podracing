//
//  ViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/14/24.
//

import UIKit
import SnapKit

private extension CGFloat {
     static let gameNameLabelOffSet: CGFloat = 70
}
private extension String {
    static let gameName = "Podracing"
    static let playButton = "Play"
    static let boardButton = "Leaderboard"
    static let settingButton = "Setting"
}
private extension CGFloat {
    static let GameLabelFont:CGFloat = 45
    static let ButtonFont:CGFloat = 20
}

class ViewController: UIViewController {
    // MARK: - Property
    
    private let menuScreen: UIImageView = {
        let menuView = UIImageView()
        return menuView
    }()
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Starjedi", size: CGFloat.GameLabelFont )
        label.textColor = .white
        label.text = String.gameName
        return label
    }()
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.playButton, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: "Starjedi", size: CGFloat.ButtonFont)
        return button
    }()
    private let boardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.boardButton, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: "Starjedi", size: CGFloat.ButtonFont)
        return button
    }()
    private let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.settingButton, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: "Starjedi", size: CGFloat.ButtonFont)
        return button
    }()
    
   /* @IBOutlet weak var menuScreen: UIImageView! +
    @IBOutlet weak var gameNameLabel: UILabel! +
    @IBOutlet weak var playButton: UIButton! +
    @IBOutlet weak var boardButton: UIButton!
    @IBOutlet weak var settingButton: UIButton! */
    
    // MARK: - life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuratMenuUI()
    }
    
    private func configuratMenuUI() {
        view.addSubview(menuScreen)
        view.addSubview(gameNameLabel)
        view.addSubview(playButton)
        view.addSubview(boardButton)
        view.addSubview(settingButton)
        let menuImage = UIImage(named: "menuScreen")
        menuScreen.image = menuImage
        menuScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        gameNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat.gameNameLabelOffSet)
        }
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(gameNameLabel.snp.bottom).offset(20)
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
    //MARK: - IBAction
    
   /* @IBAction func playPressed(_ sender: UIButton) {
    }
    @IBAction func boardPressed(_ sender: UIButton) {
    }
    @IBAction func settingPressed(_ sender: UIButton) {
    }*/
}


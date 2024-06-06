//
//  SettingsViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Buttons.buttonBackLable, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return button
    }()
    private let settingImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configuratSettingUI()
        view.backgroundColor = .white
    }
    private func configuratSettingUI() {
        view.addSubview(settingImageView)
        view.addSubview(backButton)
        let settingImage = UIImage(named: Images.settings)
        settingImageView.image = settingImage
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonOffSet)
        }
        settingImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let backPressed = UIAction { _ in
            self.backPressed()
        }
        backButton.addAction(backPressed, for: .touchUpInside)
    }
    private func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}

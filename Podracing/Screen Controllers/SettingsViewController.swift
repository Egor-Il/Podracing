//
//  SettingsViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

private extension CGFloat  {
    static let buttonOffSet: CGFloat = 50
}

class SettingsViewController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configuratSettingUI()
        view.backgroundColor = .yellow
    }
        private func configuratSettingUI() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(CGFloat.buttonOffSet)
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

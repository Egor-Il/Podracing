//
//  LeaderboardViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

private extension CGFloat {
   static let buttonOffSet: CGFloat = 50
}

class LeaderboardViewController: UIViewController {
    
    private let buttonBack: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuratLeaderBoardUI()
        view.backgroundColor = .lightGray
           }
    private func configuratLeaderBoardUI() {
        view.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(CGFloat.buttonOffSet)
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

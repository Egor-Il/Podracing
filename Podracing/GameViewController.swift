//
//  GameViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/14/24.
//

import UIKit

class GameViewController: UIViewController {
    enum Direction{
        case left
        case right
    }
    // MARK: - IBOutlets
    @IBOutlet weak var trackView: UIImageView!
    @IBOutlet weak var lefySideView: UIImageView!
    @IBOutlet weak var rightSideView: UIImageView!
    @IBOutlet weak var stoneOneView: UIImageView!
    @IBOutlet weak var stoneTwoView: UIImageView!
    @IBOutlet weak var mainPodView: UIImageView!
    @IBOutlet weak var enemyPodView: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    // MARK: - life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    func shipMoving(to direction:Direction) {
        switch direction {
        case.left:  if mainPodView.frame.origin.x > self.view.frame.origin.x - 15 {
            mainPodView.frame.origin.x -= 15
        }
        case .right:
            if mainPodView.frame.origin.x + 92 < self.view.frame.width {
                mainPodView.frame.origin.x += 15
            }
        }
    }
    // MARK: - IBAction
    @IBAction func leftPressed(_ sender: UIButton) {
        shipMoving(to: .left)
    }
    @IBAction func rightPressed(_ sender: UIButton) {
        shipMoving(to: .right)
    }
}

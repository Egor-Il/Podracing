//
//  GameViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/14/24.
//

import UIKit

class GameViewController: UIViewController {
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

      // MARK: - IBAction
    }
    
    @IBAction func leftPressed(_ sender: UIButton) {
    }
    @IBAction func rightPressed(_ sender: UIButton) {
    }
    

}

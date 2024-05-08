//
//  GameViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/14/24.
//

import UIKit
import SnapKit

private extension Int {
    static let podWidth = 70
    static let podHeight = 180
    static var podPointX = 0
    static var podPointY = 0
}

class GameViewController: UIViewController {
    
    private let backButton: UIButton = {
         let button = UIButton(type: .system)
        button.setTitle(Buttons.buttonBackLable, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return button
    }()
        private var mainPod: UIImageView = {
        var pod = UIImageView()
        let mainPod = UIImage(named: Images.mainPod)
        pod.image = mainPod
        return pod
    }()
    private var track: UIImageView = {
        var trackField = UIImageView()
        let track = UIImage(named: Images.track)
        trackField.image = track
        return trackField
    }()
    private var leftCurb: UIImageView = {
        var leftSide = UIImageView()
        let leftSideImage = UIImage(named: Images.leftCurb)
        leftSide.image = leftSideImage
        return leftSide
    }()
    private var rightCurb: UIImageView = {
        var rightSide = UIImageView()
        let rightSideImage = UIImage(named: Images.rightCurb)
        rightSide.image = rightSideImage
        return rightSide
    }()
  
    private let rockOne = UIImageView()
    private let rockTwo = UIImageView()
    private let enemyPod = UIImageView()
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
        configuratGameUI()
        view.backgroundColor = .white
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func configuratGameUI() {
        Int.podPointX = Int(view.frame.width / 2) - Int.podWidth / 2
        Int.podPointY = Int(view.frame.height / 1.45)
        mainPod.frame = CGRect(x: Int.podPointX, y: Int.podPointY, width: Int.podWidth, height: Int.podHeight)
        print(Int.podWidth)
        print(Int.podPointY)
        view.addSubview(track)
       view.addSubview(leftCurb)
        view.addSubview(rightCurb)
        view.addSubview(mainPod)
        
        track.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        leftCurb.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(45)
        }
        rightCurb.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
           make.width.equalTo(45)
        }
      
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonBackOffSet)
        }
        
        let backActionPressed = UIAction { _ in
            self.backPressed()
        }
        backButton.addAction(backActionPressed, for: .touchUpInside)
    }
    
    private func backPressed() {
        navigationController?.popViewController(animated: true)
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

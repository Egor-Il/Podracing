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
    static let podEnemyWidth = 70
    static let podEnemyHeight = 180
    static let rockOneWidth = 54
    static let rockOneHeight = 115
    static let rockTwoWidth = 70
    static let rockTwoHeight = 70
    static var podPointX = 0
    static var podPointY = 0
    static let curbWidth = 45
    static let movementButtonSize = 50
    static let movementButtonOffSetSides = 50
    static let movementButtonOffSetBottom = 30
    static let podMovementStep = 25
}

class GameViewController: UIViewController {
    // MARK: - Property
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Buttons.buttonBackLable, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return button
    }()
    private let leftButton: UIButton = {
        var button = UIButton(type: .system)
        if let leftArrowImage = UIImage(systemName: "arrowshape.left.fill") {
            let tintedArrowImage = leftArrowImage.withTintColor(.white, renderingMode: .alwaysOriginal)
            button.setImage(tintedArrowImage, for: .normal)
            button.backgroundColor = .systemBrown
        }
        return button
    }()
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        if let leftArrowImage = UIImage(systemName: "arrowshape.right.fill") {
            let tintedArrowImage = leftArrowImage.withTintColor(.white, renderingMode: .alwaysOriginal)
            button.setImage(tintedArrowImage, for: .normal)
            button.backgroundColor = .systemBrown
        }
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
    private let rockOne: UIImageView = {
        let firstRock = UIImageView()
        let stoneOneImage = UIImage(named: Images.firstRock)
        firstRock.image = stoneOneImage
        return firstRock
    }()
    private let rockTwo: UIImageView = {
        let secondRock = UIImageView()
        let stoneTwoImage = UIImage(named: Images.secondRock)
        secondRock.image = stoneTwoImage
        return secondRock
    }()
    private var enemyPod: UIImageView = {
        var pod = UIImageView()
        let enemyPod = UIImage(named: Images.podTwo)
        pod.image = enemyPod
        return pod
    }()
    private var timerForEnemyPod = Timer()
    private var timetForRockOne = Timer()
    private var timetForRockTwo = Timer()
    
    enum Direction{
        case left
        case right
    }
    
    var chosenPod: Any = ""
    var chosenName: Any = ""
    var chosenBarrier: Any = ""
    
    
    // MARK: - life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
      //  loadSettings()
        configurationGameUI()
        view.backgroundColor = .white
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - UI configutarion
    private func configurationGameUI() {
        loadSettings()
        view.addSubview(track)
        view.addSubview(leftCurb)
        view.addSubview(rightCurb)
        view.addSubview(rockOne)
        view.addSubview(rockTwo)
        view.addSubview(enemyPod)
        view.addSubview(mainPod)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(backButton)
        
        
       
       // let chosenPod = UserDefaults.standard.object(forKey: SettingsKeys.pod)
       // print(chosenPod as Any)
       //var loadChosenPod = PodImages.shared?.podArray[chosenPod]
        
       // mainPod.image = loadChosenPod
       
        // MARK: - Track constraints
        track.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        leftCurb.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(Int.curbWidth)
        }
        rightCurb.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(Int.curbWidth)
        }
        // MARK: - Buttons constraints
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonOffSet)
        }
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Int.movementButtonOffSetSides)
            make.bottom.equalToSuperview().inset(Int.movementButtonOffSetBottom)
            make.width.height.equalTo(Int.movementButtonSize)
        }
        leftButton.layer.cornerRadius = CGFloat(Int.movementButtonSize / 2)
        leftButton.clipsToBounds = true
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Int.movementButtonOffSetSides)
            make.bottom.equalToSuperview().inset(Int.movementButtonOffSetBottom)
            make.width.height.equalTo(Int.movementButtonSize)
        }
        rightButton.layer.cornerRadius = CGFloat(Int.movementButtonSize / 2)
        rightButton.clipsToBounds = true
        // MARK: - View position
        Int.podPointX = Int(view.frame.width / 2) - Int.podWidth / 2
        Int.podPointY = Int(view.frame.height / 1.45)
        mainPod.frame = CGRect(x: Int.podPointX, y: Int.podPointY, width: Int.podWidth, height: Int.podHeight)
        enemyPod.frame = CGRect(x: 0, y: 0, width: Int.podEnemyWidth , height: Int.podEnemyHeight)
        rockOne.frame = CGRect(x: 0, y: 0, width: Int.rockOneWidth, height: Int.rockOneHeight)
        rockTwo.frame = CGRect(x: 0, y: 0, width: Int.rockTwoWidth, height: Int.rockTwoHeight)
        
        // MARK: - Animation function call
        timerForEnemyPod = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            self.enemyPodAnimation ()
        })
        timetForRockOne = Timer.scheduledTimer(withTimeInterval: 12, repeats: true, block: { _ in
            self.rockOneAnimation()
        })
        timetForRockTwo = Timer.scheduledTimer(withTimeInterval: 14, repeats: true, block: { _ in
                self.rockTwoAnimation()
        })
        timerForEnemyPod.fire()
        timetForRockOne.fire()
        timetForRockTwo.fire()
        podAnimation()
        // MARK: - Buttons setups
        let backActionPressed = UIAction { _ in
            self.backPressed()
        }
        let leftActionPressed = UIAction { _ in
            self.shipMovment(to: .left)
        }
        let rightActionPressed = UIAction { _ in
            self.shipMovment(to: .right)
        }
        leftButton.addAction(leftActionPressed, for: .touchUpInside)
        rightButton.addAction(rightActionPressed, for: .touchUpInside)
        backButton.addAction(backActionPressed, for: .touchUpInside)
    }
    // MARK: - Action func
    private func backPressed() {
     //   recordTime()
        navigationController?.popViewController(animated: true)
        
    }
    private func shipMovment(to direction:Direction) {
        switch direction {
        case.left:  if mainPod.frame.origin.x > self.view.frame.origin.x + CGFloat(Int.podMovementStep)  {
            UIView.animate(withDuration: 0.3) {
                self.mainPod.frame.origin.x -= CGFloat(Int.podMovementStep)
            }
        }
        case .right:
            if mainPod.frame.origin.x + mainPod.frame.width < self.view.frame.width - CGFloat(Int.podMovementStep) {
                UIView.animate(withDuration: 0.3) {
                    self.mainPod.frame.origin.x += CGFloat(Int.podMovementStep)
                }
            }
        }
    }
    private func podAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.mainPod.frame.origin.x += 1
            self.mainPod.frame.origin.y += 1
        } completion: { _ in
            self.podAnimationSecond()
        }
    }
    private func podAnimationSecond() {
        UIView.animate(withDuration: 0.3) {
            self.mainPod.frame.origin.x -= 1
            self.mainPod.frame.origin.y -= 1
        } completion: { _ in
            self.podAnimation()
        }
    }
    private func enemyPodAnimation () {
        enemyPod.frame = CGRect(x: 0, y: Int(view.frame.minY - enemyPod.frame.height), width: Int.podEnemyWidth , height: Int.podEnemyHeight)
        let minPosition = view.frame.origin.x + CGFloat(Int.podEnemyWidth)
        let maxPosition = view.frame.width - CGFloat(Int.podEnemyWidth)
        let enemyPosition = CGFloat.random(in: minPosition...maxPosition)
        self.enemyPod.center.x = enemyPosition
        UIView.animate(withDuration: 8, delay: 0.3, options: [.curveLinear]) {
            self.enemyPod.frame.origin.y += self.view.frame.height + self.enemyPod.frame.height
        }
    }
    
    private func rockOneAnimation () {
        rockOne.frame = CGRect(x: 0, y: Int(view.frame.minY - rockOne.frame.height) , width: Int.rockOneWidth, height: Int.rockOneHeight)
        let minPosition = view.frame.origin.y + CGFloat(Int.rockOneWidth)
        let maxPosition = view.frame.width - CGFloat(Int.rockOneWidth)
        let rockOnePosition = CGFloat.random(in: minPosition...maxPosition)
        self.rockOne.center.x = rockOnePosition
        UIView.animate(withDuration: 8, delay: 1.3, options: [.curveLinear]) {
            self.rockOne.frame.origin.y += self.view.frame.height + self.rockOne.frame.height
        }
    }
    private func rockTwoAnimation () {
        rockTwo.frame = CGRect(x: 0, y: Int(view.frame.minY - rockTwo.frame.height) , width: Int.rockTwoWidth, height: Int.rockTwoHeight)
        let minPosition = view.frame.origin.x + CGFloat(Int.rockTwoWidth)
        let maxPosition = view.frame.width - CGFloat(Int.rockTwoWidth)
        let rockTwoPosition = CGFloat.random(in: minPosition...maxPosition) // - надо создать одну переменную на все обьекты 
        self.rockTwo.center.x = rockTwoPosition
        UIView.animate(withDuration: 8, delay: 2.3, options: [.curveLinear]) {
            self.rockTwo.frame.origin.y += self.view.frame.height + self.rockTwo.frame.height
        }
    }
    private func loadSettings() {
        chosenPod = UserDefaults.standard.object(forKey: SettingsKeys.pod) as Any
        chosenName = UserDefaults.standard.object(forKey: SettingsKeys.playerName)!
        chosenBarrier = UserDefaults.standard.object(forKey: SettingsKeys.barrier) ?? 0
        print() // какой вариант лучше?
    }
//    func recordTime() {
//        let savedDate = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM d, yyyy, HH:mm"
//        let savedRaceDate = formatter.string(from: savedDate)
//        print(savedRaceDate)
//        LeaderboardViewController().leaderboardText.text = savedRaceDate
//    }
    // MARK: - IBAction
    
    
}

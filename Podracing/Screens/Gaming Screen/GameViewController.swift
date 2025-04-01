//
//  GameViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/14/24.
//

import UIKit
import SnapKit

//private extension Int {
//    static let podWidth = 70
//    static let podHeight = 180
//    static let podEnemyWidth = 70
//    static let podEnemyHeight = 180
//    static let rockOneWidth = 54
//    static let rockOneHeight = 115
//    static let rockTwoWidth = 70
//    static let rockTwoHeight = 70
//    static var podPointX = 0
//    static var podPointY = 0
//    static let curbWidth = 45
//    static let movementButtonSize = 50
//    static let movementButtonOffSetSides = 50
//    static let movementButtonOffSetBottom = 30
//    static let podMovementStep = 25
//}

private enum Constraint {
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

final class GameViewController: UIViewController {
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
        let pod = UIImageView()
        let enemyPod = UIImage(named: Images.podTwo)
        pod.image = enemyPod
        return pod
    }()
    
    private lazy var scoreLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        label.textColor = .white
        label.text = "Score: \(score)"
        return label
    }()
    
    private var timerForEnemyPod = Timer()
    private var timetForRockOne = Timer()
    private var timetForRockTwo = Timer()
    
    enum Direction{
        case left
        case right
    }
    
    private var podStartPosition: CGPoint = .zero // записываем стартовоую вычисленную точку что бы использовать ее для рестарата
    
    private var displayLink: CADisplayLink?
    private var enemyPodPassed = false
    private var rockOnePassed = false
    private var rockTwoPassed = false
    
    private var isMovingLeft = false
    
    private var score: Int = 0
    //    var chosenPod: Any = ""
    //    var chosenName: Any = ""
    //    var chosenBarrier: Any = ""
    
    
    // MARK: - life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //  loadSettings()
        configurationGameUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startGame()
    }
    // MARK: - UI configutarion
    private func configurationGameUI() {
        // loadSettings()
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
        view.addSubview(scoreLable)
        
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
            make.width.equalTo(Constraint.curbWidth)
        }
        rightCurb.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(Constraint.curbWidth)
        }
        // MARK: - Buttons constraints
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonOffSet)
        }
        scoreLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Buttons.buttonOffSet)
            make.right.equalToSuperview().inset(60)
        }
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constraint.movementButtonOffSetSides)
            make.bottom.equalToSuperview().inset(Constraint.movementButtonOffSetBottom)
            make.width.height.equalTo(Constraint.movementButtonSize)
        }
        leftButton.layer.cornerRadius = CGFloat(Constraint.movementButtonSize / 2)
        leftButton.clipsToBounds = true
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constraint.movementButtonOffSetSides)
            make.bottom.equalToSuperview().inset(Constraint.movementButtonOffSetBottom)
            make.width.height.equalTo(Constraint.movementButtonSize)
        }
        rightButton.layer.cornerRadius = CGFloat(Constraint.movementButtonSize / 2)
        rightButton.clipsToBounds = true
        
        // MARK: - View position
        Constraint.podPointX = Int(view.frame.width / 2) - Constraint.podWidth / 2
        Constraint.podPointY = Int(view.frame.height / 1.45)
        
        mainPod.frame = CGRect(x: Constraint.podPointX, y: Constraint.podPointY, width: Constraint.podWidth, height: Constraint.podHeight)
        podStartPosition = CGPoint(x: Constraint.podPointX, y: Constraint.podPointY) // записываем стартовоую вычисленную точку что бы использовать ее для рестарата
        
        enemyPod.frame = CGRect(x: 0, y: 0, width: Constraint.podEnemyWidth , height: Constraint.podEnemyHeight)
        rockOne.frame = CGRect(x: 0, y: 0, width: Constraint.rockOneWidth, height: Constraint.rockOneHeight)
        rockTwo.frame = CGRect(x: 0, y: 0, width: Constraint.rockTwoWidth, height: Constraint.rockTwoHeight)
        
        // MARK: - Animation function call
        startTimerForObstacles()
        podAnimation()
        
        // MARK: - Left/Right buttons setups
        let backActionPressed = UIAction { _ in
            self.backPressed()
        }
        let leftActionPressed = UIAction { _ in
            self.shipMovment(to: .left)
        }
        let rightActionPressed = UIAction { _ in
            self.shipMovment(to: .right)
        }
        
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressLeft))
//        longPress.minimumPressDuration = 0.1
//        leftButton.addGestureRecognizer(longPress)
        
        leftButton.addAction(leftActionPressed, for: .touchUpInside)
        rightButton.addAction(rightActionPressed, for: .touchUpInside)
        backButton.addAction(backActionPressed, for: .touchUpInside)
        
    }
    // MARK: - Action func
    private func backPressed() {
        let alert = UIAlertController(title: "Are you sure you want to exit the game", message: "all progress will be lost", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .destructive, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        //   recordTime()
        
    }
    private func startTimerForObstacles() {
        timerForEnemyPod = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { [weak self] _ in
            self?.enemyPodAnimation ()
        }) // weak для недопущения утечки памяти
        timetForRockOne = Timer.scheduledTimer(withTimeInterval: 12, repeats: true, block: {  [weak self] _ in
            self?.rockOneAnimation()
        }) // weak для недопущения утечки памяти
        timetForRockTwo = Timer.scheduledTimer(withTimeInterval: 14, repeats: true, block: { [weak self] _ in
            self?.rockTwoAnimation()
        })  // weak для недопущения утечки памяти
        timerForEnemyPod.fire()
        timetForRockOne.fire()
        timetForRockTwo.fire()
    }
    
    private func pauseTimerForObstacles() {
        timerForEnemyPod.invalidate()
        timetForRockOne.invalidate()
        timetForRockTwo.invalidate()
    }
    private func shipMovment(to direction:Direction) {
        switch direction {
        case.left:  if mainPod.frame.origin.x > self.view.frame.origin.x + CGFloat(Constraint.podMovementStep)  {
            UIView.animate(withDuration: 0.3) {
                self.mainPod.frame.origin.x -= CGFloat(Constraint.podMovementStep)
            }
        }
        case .right:
            if mainPod.frame.origin.x + mainPod.frame.width < self.view.frame.width - CGFloat(Constraint.podMovementStep) {
                UIView.animate(withDuration: 0.3) {
                    self.mainPod.frame.origin.x += CGFloat(Constraint.podMovementStep)
                }
            }
        }
    }
    
//    @objc func longPressLeft(gesture: UILongPressGestureRecognizer) {
//        switch gesture.state {
//            case .began:
//                isMovingLeft = true
//                moveLeftContinuously()
//            case .ended, .cancelled:
//                isMovingLeft = false
//            default:
//                break
//            }
//    }
//    
//    private func moveLeftContinuously () {
//        guard isMovingLeft else { return }
//        
//        shipMovment(to: .left)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
//            self?.moveLeftContinuously()
//        }
//    }
    
    private func podAnimation() {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [.autoreverse, .repeat]) {
            self.mainPod.transform = CGAffineTransform(translationX: 1, y: 1)
            // self.mainPod.transform = CGAffineTransform(scaleX: 1.1, y: 1.1) другой вид анимации
        }
    }
    
    private func enemyPodAnimation () {
        enemyPod.frame = CGRect(x: 0, y: Int(view.frame.minY - enemyPod.frame.height), width: Constraint.podEnemyWidth , height: Constraint.podEnemyHeight)
        let minPosition = view.frame.origin.x + CGFloat(Constraint.podEnemyWidth)
        let maxPosition = view.frame.width - CGFloat(Constraint.podEnemyWidth)
        
        let enemyPosition = CGFloat.random(in: minPosition...maxPosition)
        self.enemyPod.center.x = enemyPosition
        
        UIView.animate(withDuration: 8, delay: 0.3, options: [.curveLinear]) {
            self.enemyPod.frame.origin.y += self.view.frame.height + self.enemyPod.frame.height
        }
    }
    
    private func rockOneAnimation () {
        rockOne.frame = CGRect(x: 0, y: Int(view.frame.minY - rockOne.frame.height) , width: Constraint.rockOneWidth, height: Constraint.rockOneHeight)
        let minPosition = view.frame.origin.y + CGFloat(Constraint.rockOneWidth)
        let maxPosition = view.frame.width - CGFloat(Constraint.rockOneWidth)
        let rockOnePosition = CGFloat.random(in: minPosition...maxPosition)
        self.rockOne.center.x = rockOnePosition
        UIView.animate(withDuration: 8, delay: 3.3, options: [.curveLinear]) {
            self.rockOne.frame.origin.y += self.view.frame.height + self.rockOne.frame.height
        }
    }
    private func rockTwoAnimation () {
        rockTwo.frame = CGRect(x: 0, y: Int(view.frame.minY - rockTwo.frame.height) , width: Constraint.rockTwoWidth, height: Constraint.rockTwoHeight)
        let minPosition = view.frame.origin.x + CGFloat(Constraint.rockTwoWidth)
        let maxPosition = view.frame.width - CGFloat(Constraint.rockTwoWidth)
        let rockTwoPosition = CGFloat.random(in: minPosition...maxPosition) // - надо создать одну переменную на все обьекты
        self.rockTwo.center.x = rockTwoPosition
        UIView.animate(withDuration: 8, delay: 5.3, options: [.curveLinear]) {
            self.rockTwo.frame.origin.y += self.view.frame.height + self.rockTwo.frame.height
        }
    }
    
    private func startGame() {
        displayLink = CADisplayLink(target: self, selector: #selector(checkCollision))
        displayLink?.add(to: .main, forMode: .default)
    }
    private func reStartGame() {
        mainPod.frame.origin = podStartPosition
        leftButton.isEnabled = true
        rightButton.isEnabled = true
        startGame()
        podAnimation()
        startTimerForObstacles()
        score = 0
        scoreLable.text = "Score: \(score)"
    }
    
    private func gameOver() {
        displayLink?.invalidate()
        displayLink = nil
        freezeAnimations()
        view.subviews.forEach { $0.layer.removeAllAnimations() }
        
        
        pauseTimerForObstacles()
        let alert = UIAlertController(title: "Game Over", message: "Yor record is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: { _ in
            self.exitToMainMenu()
        }))
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.reStartGame()
        }))
        present(alert,animated: true)
    }
    
    private func freezeAnimations() {
        view.subviews.forEach { subview in
            let layer = subview.layer
            if let presentationLayer = layer.presentation() {
                layer.position = presentationLayer.position
                layer.transform = presentationLayer.transform
            }
            layer.removeAllAnimations()
        }
    }
    
    @objc private func checkCollision() {
        guard let mainFrame = mainPod.layer.presentation()?.frame,
              let enemyFrame = enemyPod.layer.presentation()?.frame,
              let rockOneFrame = rockOne.layer.presentation()?.frame,
              let rockTwoFrame = rockTwo.layer.presentation()?.frame else { return }
        
        var explosionCenter: CGPoint?
        
        enemyPodPassed = checkForObstaclePassed(mainPod: mainFrame.maxY, obstacle: enemyFrame.minY, flag: enemyPodPassed)
        rockOnePassed = checkForObstaclePassed(mainPod: mainFrame.maxY, obstacle: rockOneFrame.minY, flag: rockOnePassed)
        rockTwoPassed = checkForObstaclePassed(mainPod: mainFrame.maxY, obstacle: rockTwoFrame.minY, flag: rockTwoPassed)
        
        if mainFrame.intersects(enemyFrame) {
            explosionCenter = CGPoint(x: (mainFrame.midX + enemyFrame.midX) / 2,
                                      y: (mainFrame.midY + enemyFrame.midY) / 2)
        } else if mainFrame.intersects(rockOneFrame) {
            explosionCenter = CGPoint(x: (mainFrame.midX + rockOneFrame.midX) / 2,
                                      y: (mainFrame.midY + rockOneFrame.midY) / 2)
        } else if mainFrame.intersects(rockTwoFrame) {
            explosionCenter = CGPoint(x: (mainFrame.midX + rockTwoFrame.midX) / 2,
                                      y: (mainFrame.midY + rockTwoFrame.midY) / 2)
        }
        if let center = explosionCenter {
            explosionAnimation(at: center)
            leftButton.isEnabled = false
            rightButton.isEnabled = false
            gameOver()
        }
    }
    
    private func explosionAnimation(at center: CGPoint) {
        let explosionSize = CGSize(width: 100, height: 100)
        let explosion = UIImageView(image: UIImage(named: "explosionOne"))
        
        explosion.frame = CGRect(
            x: center.x - explosionSize.width / 2,
            y: center.y - explosionSize.height / 2,
            width: explosionSize.width,
            height: explosionSize.height
        )
        explosion.alpha = 0
        view.addSubview(explosion)
        
        UIView.animate(withDuration: 0.3, animations: {
            explosion.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
                explosion.alpha = 0
            }) { _ in
                explosion.removeFromSuperview()
            }
        }
    }
    
    private func checkForObstaclePassed (mainPod: CGFloat, obstacle: CGFloat, flag: Bool) -> Bool {
        var swichingFlag = flag
        
        if mainPod < obstacle && !swichingFlag {
            swichingFlag = true
            score += 1
            scoreLable.text = "Score: \(score)"
            print("Score: \(score)")
        }
        if obstacle <= 0 {
            swichingFlag = false
        }
        return swichingFlag
    }
    
    private func exitToMainMenu() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //    private func loadSettings() {
    //        chosenPod = UserDefaults.standard.object(forKey: SettingsKeys.pod) as Any
    //        chosenName = UserDefaults.standard.object(forKey: SettingsKeys.playerName)!
    //        chosenBarrier = UserDefaults.standard.object(forKey: SettingsKeys.barrier) ?? 0
    //        print() // какой вариант лучше?
    //    }
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

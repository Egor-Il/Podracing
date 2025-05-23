//
//  GameViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/14/24.
//

import UIKit
import SnapKit

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
        button.setTitle(GameConstants.Strings.backButton, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: GameConstants.Font.fontName, size: GameConstants.Font.buttonBackFontSize)
        return button
    }()
    private let leftButton: UIButton = {
        var button = UIButton(type: .system)
        if let leftArrowImage = UIImage(systemName: GameConstants.Strings.leftButton) {
            let tintedArrowImage = leftArrowImage.withTintColor(.white, renderingMode: .alwaysOriginal)
            button.setImage(tintedArrowImage, for: .normal)
            button.backgroundColor = .systemBrown
        }
        return button
    }()
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        if let leftArrowImage = UIImage(systemName: GameConstants.Strings.rightButton) {
            let tintedArrowImage = leftArrowImage.withTintColor(.white, renderingMode: .alwaysOriginal)
            button.setImage(tintedArrowImage, for: .normal)
            button.backgroundColor = .systemBrown
        }
        return button
    }()
    private var mainPod: UIImageView = {
        var pod = UIImageView()
        let mainPod = UIImage(named: GameConstants.Strings.mainPodPic)
        pod.image = mainPod
        return pod
    }()
    
    private let trackImages: [UIImageView] = (0..<3).map { _ in
        let imageView = UIImageView()
        imageView.image = UIImage(named: GameConstants.Strings.trackPic)
        return imageView
    }
    
    private let rockOne: UIImageView = {
        let firstRock = UIImageView()
        let stoneOneImage = UIImage(named: GameConstants.Strings.stoneOnePic)
        firstRock.image = stoneOneImage
        return firstRock
    }()
    private let rockTwo: UIImageView = {
        let secondRock = UIImageView()
        let stoneTwoImage = UIImage(named: GameConstants.Strings.stoneTwoPic)
        secondRock.image = stoneTwoImage
        return secondRock
    }()
    private var enemyPod: UIImageView = {
        let pod = UIImageView()
        let enemyPod = UIImage(named: GameConstants.Strings.enemyPod)
        pod.image = enemyPod
        return pod
    }()
    
    private lazy var scoreLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: GameConstants.Font.fontName, size: GameConstants.Font.scoreLablFontSize)
        label.textColor = .white
        label.text = "Score: \(score)"
        return label
    }()
    
    private lazy var countdownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: GameConstants.Font.fontName, size: GameConstants.Font.countdownLabelFontSize)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    enum Direction{
        case left
        case right
    }
    
    private var podStartPosition: CGPoint = .zero // create start position for restar game
    
    private var gameDisplayLink: CADisplayLink?
    
    private var enemyPodPassed = false
    private var rockOnePassed = false
    private var rockTwoPassed = false
    
    private var isMovingLeft = false
    
    private var score = GameConstants.Value.score
    private  var nextScoreThreshold = GameConstants.Value.nextScoreThreshold
    private var playerName:String = ""
    private var chosenGameSpeed: Double?
    
    // MARK: - life cycle functions
    override func viewDidLoad() {
        
        super.viewDidLoad()
        reloadSettings()
        configurationGameUI()
    }
    
    // MARK: - UI configutarion
    private func configurationGameUI() {
        
        for track in trackImages {
            view.addSubview(track)
        }
        view.addSubview(rockOne)
        view.addSubview(rockTwo)
        view.addSubview(enemyPod)
        view.addSubview(mainPod)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(backButton)
        view.addSubview(scoreLable)
        setupConstraints()
        
        leftButton.layer.cornerRadius = CGFloat(Constraint.movementButtonSize / 2)
        leftButton.clipsToBounds = true
        rightButton.layer.cornerRadius = CGFloat(Constraint.movementButtonSize / 2)
        rightButton.clipsToBounds = true
        
        // MARK: - View position
        
        for (index, track) in trackImages.enumerated() {
            track.frame = CGRect(x: 0,
                                 y: -view.frame.height * CGFloat(index),
                                 width: view.frame.width,
                                 height: view.frame.height)
        }
        
        setStartingPosition()
        // MARK: - Animation function call
 
        
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
        leftButton.addAction(leftActionPressed, for: .touchUpInside)
        rightButton.addAction(rightActionPressed, for: .touchUpInside)
        backButton.addAction(backActionPressed, for: .touchUpInside)
        reloadSettings()
        addCoundown()
        countdownAnimation(number: 3)
    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(GameConstants.Layout.backButtonOffset)
        }
        scoreLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(GameConstants.Layout.scoreLablOffsetTop)
            make.right.equalToSuperview().inset(GameConstants.Layout.scoreLablOffsetRight)
        }
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constraint.movementButtonOffSetSides)
            make.bottom.equalToSuperview().inset(Constraint.movementButtonOffSetBottom)
            make.width.height.equalTo(Constraint.movementButtonSize)
        }
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constraint.movementButtonOffSetSides)
            make.bottom.equalToSuperview().inset(Constraint.movementButtonOffSetBottom)
            make.width.height.equalTo(Constraint.movementButtonSize)
        }
    }
    
    private func addCoundown() {
        view.addSubview(countdownLabel)
        countdownLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    // MARK: - Countdown Animtion
    private func countdownAnimation(number: Int) {
        countdownLabel.text = "\(number)"
        countdownLabel.alpha = 1
        UIView.animate(withDuration: 1) {
            self.countdownLabel.alpha = 0
            self.countdownLabel.transform = CGAffineTransform(scaleX: 20, y: 20)
        } completion: { _ in
            if number > 1 {
                self.countdownLabel.alpha = 1
                self.countdownLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.countdownAnimation(number: number - 1)
            } else if number == 1 {
                self.animateGo()
            }
        }
    }
    private func animateGo() {
        countdownLabel.text = GameConstants.Strings.countdownLabelGo
        countdownLabel.alpha = 1
        countdownLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        UIView.animate(withDuration: 1) {
            self.countdownLabel.alpha = 0
            self.countdownLabel.transform = CGAffineTransform(scaleX: 20, y: 20)
        } completion: { _ in
            self.removeCountdown()
            self.startGame()
            self.podAnimation()
        }
    }
    private func removeCountdown() {
        countdownLabel.removeFromSuperview()
    }
    // MARK: - Buttons Setup
    private func backPressed() {
        pauseGame()
        let alert = UIAlertController(title: GameConstants.Strings.backAlertTitle, message: GameConstants.Strings.backAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: GameConstants.Strings.backAlertTitleExit, style: .destructive, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: GameConstants.Strings.backAlertTitleCancel, style: .cancel, handler: { _ in
            self.resumeGame()
        }))
        present(alert, animated: true)
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
    private func exitToMainMenu() {
        stopGame()
        navigationController?.popToRootViewController(animated: true)
    }
    // MARK: - Buttons Setup
    private func reloadSettings() {
        guard let savedSettings = UserDefaults.standard.value(SavedSettings.self, forKey: SettingsConstants.userDefaults.playerSettings) else {
            playerName = GameConstants.Strings.defaultPlayerName
            return
        }
        mainPod.image = UIImage(named: savedSettings.selectedPod)
        //        barrierImage.image = UIImage(named: savedSettings.barrierName)
        playerName = savedSettings.playerName
        chosenGameSpeed = savedSettings.difficultyLevelValue
    }
    
    func recordTime() -> String {
        let savedDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = GameConstants.Strings.dateFormat
        let savedRaceDate = formatter.string(from: savedDate)
        return savedRaceDate
    }
    
     private func updateTracks() {
        for track in trackImages {
            track.frame.origin.y += chosenGameSpeed ?? 3
        }
        for track in trackImages {
            if track.frame.origin.y >= view.frame.height {
                if let topY = trackImages.map({ $0.frame.origin.y }).min() {
                    track.frame.origin.y = topY - view.frame.height
                }
            }
        }
    }
    
    private func setStartingPosition() {
        enemyPod.isHidden = false
        rockOne.isHidden = false
        rockTwo.isHidden = false
        
        Constraint.podPointX = Int(view.frame.width / 2) - Constraint.podWidth / 2
        Constraint.podPointY = Int(view.frame.height / 1.45)
        mainPod.frame = CGRect(x: Constraint.podPointX, y: Constraint.podPointY, width: Constraint.podWidth, height: Constraint.podHeight)
        podStartPosition = CGPoint(x: Constraint.podPointX, y: Constraint.podPointY) //  create starting position for restart
        
        let minXPodPosition = Constraint.podEnemyWidth / 2
        let maxXPodPosition = Int(view.frame.width) - Constraint.podEnemyWidth - minXPodPosition
        let randomPodPosition = Int.random(in: minXPodPosition...maxXPodPosition)
        
        let sectorCount = 3
        let sectorWidth = Int(view.frame.width) / sectorCount
        
        let rockOneX = Int.random(in: 0..<sectorWidth)
        let rockTwoX = Int.random(in: sectorWidth..<(2 * sectorWidth))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.rockTwo.frame = CGRect(x: rockTwoX, y: -Constraint.rockTwoHeight, width: Constraint.rockTwoWidth, height: Constraint.rockTwoHeight)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.enemyPod.frame = CGRect(x: randomPodPosition, y: -Constraint.podEnemyHeight, width: Constraint.podEnemyWidth , height: Constraint.podEnemyHeight)
        }
        rockOne.frame = CGRect(x: rockOneX, y: -Constraint.rockOneHeight, width: Constraint.rockOneWidth, height: Constraint.rockOneHeight)
    }
    
    
    
    private func podAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
            self.mainPod.transform = CGAffineTransform(translationX: 1, y: 1)
        })
    }
    
     private func enemyMovement() {
        enemyPod.frame.origin.y += (chosenGameSpeed ?? 3) - 1
        if enemyPod.frame.origin.y > view.frame.height {
            enemyPod.frame.origin.y = -enemyPod.frame.height
            let minPosition = view.frame.origin.x + CGFloat(Constraint.podEnemyWidth)
            let maxPosition = view.frame.width - CGFloat(Constraint.podEnemyWidth)
            let enemyPosition = CGFloat.random(in: minPosition...maxPosition)
            self.enemyPod.center.x = enemyPosition
        }
    }
    
     private func obstacleOneMovement() {
        rockOne.frame.origin.y += chosenGameSpeed ?? 3
        if rockOne.frame.origin.y > view.frame.height {
            rockOne.frame.origin.y = -rockOne.frame.origin.y
            let minPosition = view.frame.origin.y + CGFloat(Constraint.rockOneWidth)
            let maxPosition = view.frame.width - CGFloat(Constraint.rockOneWidth)
            let rockOnePosition = CGFloat.random(in: minPosition...maxPosition)
            self.rockOne.center.x = rockOnePosition
        }
    }
     private func obstacleTwoMovement() {
        rockTwo.frame.origin.y += chosenGameSpeed ?? 3
        if rockTwo.frame.origin.y > view.frame.height {
            rockTwo.frame.origin.y = -rockTwo.frame.origin.y
            let minPosition = view.frame.origin.x + CGFloat(Constraint.rockTwoWidth)
            let maxPosition = view.frame.width - CGFloat(Constraint.rockTwoWidth)
            let rockTwoPosition = CGFloat.random(in: minPosition...maxPosition) // - надо создать одну переменную на все обьекты
            self.rockTwo.center.x = rockTwoPosition
        }
    }
    
    private func dynamicScoreChange() {
        if score >= nextScoreThreshold {
            chosenGameSpeed! += 0.5
            nextScoreThreshold += 10
            print(nextScoreThreshold)
        }
    }
    
    
    private func startGame() {
        gameDisplayLink = CADisplayLink(target: self, selector: #selector(startGameplay))
        gameDisplayLink?.add(to: .main, forMode: .common)
    }
    
    private func reStartGame() {
        cleanObstacles()
        mainPod.frame.origin = podStartPosition
        leftButton.isEnabled = true
        rightButton.isEnabled = true
        resetScore()
        setStartingPosition()
        startGame()
        podAnimation()
    }
    
    private func resetScore() {
        score = 0
        scoreLable.text = "Score: \(score)"
    }
    private func cleanObstacles() {
        [enemyPod, rockOne, rockTwo].forEach {
            $0.layer.removeAllAnimations()
            $0.isHidden = true
            $0.frame = .zero
        }
    }
    
    private func gameOver() {
       stopGame()
       freezeAnimations()
        
        mainPod.layer.removeAllAnimations()
        mainPod.transform = .identity  // this 2 line of code helps prevent the animation from freezing after a restart
        
        let alert = UIAlertController(title: GameConstants.Strings.gameOverAlertTitle, message: "Yor record is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: GameConstants.Strings.gameOverExitButton, style: .default, handler: { _ in
            self.exitToMainMenu()
        }))
        alert.addAction(UIAlertAction(title: GameConstants.Strings.gameOverRestartButton, style: .default, handler: { _ in
            self.reStartGame()
        }))
        present(alert,animated: true)
        LeaderboardManager.shared.addRecord(record: score, playerName: playerName, date: recordTime())
        
    }
    
    
    private func stopGame() {
        gameDisplayLink?.invalidate()
        gameDisplayLink = nil
    }
    
    private func pauseGame() {
        gameDisplayLink?.isPaused = true
    }
    
    private func resumeGame() {
        gameDisplayLink?.isPaused = false
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
    
    @objc private func startGameplay() {
        updateTracks()
        enemyMovement()
        obstacleOneMovement()
        obstacleTwoMovement()
        checkCollision()
        dynamicScoreChange()
    }
    
     private func checkCollision() {
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
        let explosion = UIImageView(image: UIImage(named: GameConstants.Strings.explosionAnimationPic))
        
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
        }
        if obstacle <= 0 {
            swichingFlag = false
        }
        return swichingFlag
    }
}

//
//  SettingsViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    // MARK: - Property
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Buttons.buttonBackLable, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return button
    }()
    private let settingImageView: UIImageView = {
        let image = UIImageView()
        let settingImage = UIImage(named: Images.settings)
        image.image = settingImage
        return image
    }()
    private let sittingsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 30
        return view
    }()
    private let podSettingsContainer: UIView = {
        let view = UIView()
        return view
    }()
    private let barrierSettingsContainer: UIView = {
        let view = UIView()
        return view
    }()
    private let podChoiceleftButton: UIButton = {
        let button = UIButton(type: .system)
        let leftChoice =  UIImage(systemName: "arrowshape.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        button.setImage(leftChoice, for: .normal)
        return button
    }()
    private let podChoiceRightButton: UIButton = {
        let button = UIButton(type: .system)
        let rightChoice =  UIImage(systemName: "arrowshape.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        button.setImage(rightChoice, for: .normal)
        return button
    }()
    private var mainPodImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Images.mainPod)
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let podLabel: UILabel = {
        let label = UILabel()
        label.text = "selected pod" // do I need to move it to extension?
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return label
    }()
    private let barrierChoiceleftButton: UIButton = {
        let button = UIButton(type: .system)
        let leftChoice =  UIImage(systemName: "arrowshape.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        button.setImage(leftChoice, for: .normal)
        return button
    }()
    private let barrierChoiceRightButton: UIButton = {
        let button = UIButton(type: .system)
        let rightChoice =  UIImage(systemName: "arrowshape.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        button.setImage(rightChoice, for: .normal)
        return button
    }()
    private let barrierImage: UIImageView = {
        let view = UIImageView()
        let startingBarrier = UIImage(named: "stoneOne")
        view.image = startingBarrier
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let barrierLabel: UILabel = {
        let label = UILabel()
        label.text = "selected barrier" // do I need to move it to extension?
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return label
    }()
    private let userNameContainer: UIView = {
        let view = UIView()
        return view
    }()
    lazy var userName: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Player"  // do I need to move it to extension?
        textField.delegate = self
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "player name" // do I need to move it to extension?
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return label
    }()
    
    private  let sliderContainer: UIView = {
        let container = UIView()
        return container
    }()
    private let difficultySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 2
        slider.value = 1
        slider.isContinuous = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .blue
        return slider
    }()
    private let difficultyLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "Difficulty Level"  // do I need to move it to extension?
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return label
    }()
    private let sliderDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "medium"   // do I need to move it to extension?
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return label
    }()
    
    private var currentPodIndex = 0
    private var currentBarrierIndex = 0
    
    private var chosenPlayerName: String?
    private var chosenMainPod: String?
    private var chosenBarrier: String?
    private var chosenDifficult: String?
    private var chosenDifficultValue: Double?
    private var chosenSliderPosition: Float?
    
    enum podImageChoice{
        case left
        case right
    }
    enum barrierImageChoice{
        case left
        case right
    }
    enum DifficultyLevel: String {
        case easy
        case medium
        case hard
        
        var speed: Double {
            switch self {
            case .easy: return 2
            case .medium:  return 3
            case .hard: return 5
            }
        }
    }
    
    // MARK: - life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        preLoadSavedSettings()
        configureSettingsUI()
        
    }
    
    // MARK: - UI configutarion
    private func configureSettingsUI() {
        
        configuratNotifications()
        view.addSubview(settingImageView)
        view.addSubview(backButton)
        view.addSubview(sittingsContainer)
        sittingsContainer.addSubview(podSettingsContainer)
        podSettingsContainer.addSubview(podChoiceleftButton)
        podSettingsContainer.addSubview(podChoiceRightButton)
        podSettingsContainer.addSubview(mainPodImage)
        podSettingsContainer.addSubview(podLabel)
        sittingsContainer.addSubview(barrierSettingsContainer)
        barrierSettingsContainer.addSubview(barrierChoiceleftButton)
        barrierSettingsContainer.addSubview(barrierChoiceRightButton)
        barrierSettingsContainer.addSubview(barrierImage)
        barrierSettingsContainer.addSubview(barrierLabel)
        sittingsContainer.addSubview(userNameContainer)
        userNameContainer.addSubview(userName)
        userNameContainer.addSubview(userNameLabel)
        sittingsContainer.addSubview(sliderContainer)
        sliderContainer.addSubview(difficultyLevelLabel)
        sliderContainer.addSubview(difficultySlider)
        sliderContainer.addSubview(sliderDifficultyLabel)
        
        setupConstraints()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        // MARK: - Buttons setup
        
        let backPressed = UIAction { _ in
            self.backPressed()
        }
        let podLeftChoise = UIAction { _ in
            self.podChoice(to: .left)
        }
        let podRightChoise = UIAction { _ in
            self.podChoice(to: .right)
        }
        let barrierLeftChoise = UIAction { _ in
            self.barrierChoice(to: .left)
        }
        let barrierRightChoise = UIAction { _ in
            self.barrierChoice(to: .right)
        }
        backButton.addAction(backPressed, for: .touchUpInside)
        podChoiceleftButton.addAction(podLeftChoise, for: .touchUpInside)
        podChoiceRightButton.addAction(podRightChoise, for: .touchUpInside)
        barrierChoiceleftButton.addAction(barrierLeftChoise, for: .touchUpInside)
        barrierChoiceRightButton.addAction(barrierRightChoise, for: .touchUpInside)
        difficultySlider.addTarget(self, action: #selector(difficultyChanged(_ : )), for: .valueChanged)
        reloadSettings()
    }
    // MARK: - Functions
    private func setupConstraints() {
        settingImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(Buttons.buttonOffSet)
        }
        sittingsContainer.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.bottom.equalToSuperview().inset(30)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        }
        podSettingsContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        podChoiceleftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.width.height.equalTo(50)
        }
        podChoiceRightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
            make.width.height.equalTo(50)
        }
        podLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(podChoiceleftButton.snp.right)
            make.right.equalTo(podChoiceRightButton.snp.left)
            make.height.equalTo(20)
        }
        mainPodImage.snp.makeConstraints { make in
            make.top.equalTo(podLabel.snp.bottom).offset(5)
            make.left.equalTo(podChoiceleftButton.snp.right)
            make.right.equalTo(podChoiceRightButton.snp.left)
            make.bottom.equalToSuperview().inset(5)
        }
        barrierSettingsContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(podSettingsContainer.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        barrierChoiceleftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(50)
        }
        barrierChoiceRightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.height.equalTo(50)
        }
        barrierLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(barrierChoiceleftButton.snp.right)
            make.right.equalTo(barrierChoiceRightButton.snp.left)
            make.height.equalTo(20)
        }
        barrierImage.snp.makeConstraints { make in
            make.top.equalTo(barrierLabel.snp.bottom).offset(5)
            make.left.equalTo(barrierChoiceleftButton.snp.right)
            make.right.equalTo(barrierChoiceRightButton.snp.left)
            make.bottom.equalToSuperview().inset(5)
        }
        userNameContainer.snp.makeConstraints { make in
            make.top.equalTo(barrierSettingsContainer.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        userName.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(1.25)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().inset(5)
        }
        userNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(userName.snp.top).offset(-5)
        }
        sliderContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(userNameContainer.snp.bottom)
            make.bottom.equalToSuperview()
        }
        difficultySlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        sliderDifficultyLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(difficultySlider.snp.bottom)
        }
        difficultyLevelLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(difficultySlider.snp.top).offset(-5)
        }
    }
    
    private func reloadSettings() {
        guard let savedSettings = UserDefaults.standard.value(SavedSettins.self, forKey: SettingsKeys.playerSettings) else { return }
        mainPodImage.image = UIImage(named: savedSettings.selectedPod)
        barrierImage.image = UIImage(named: savedSettings.barrierName)
        userName.text = savedSettings.playerName
        sliderDifficultyLabel.text = savedSettings.difficultyLevel
        difficultySlider.value = chosenSliderPosition ?? 1
    }
    private func preLoadSavedSettings() {
        if let saved = UserDefaults.standard.value(SavedSettins.self, forKey: SettingsKeys.playerSettings) {
            chosenPlayerName = saved.playerName
            chosenMainPod = saved.selectedPod
            chosenBarrier = saved.barrierName
            chosenDifficult = saved.difficultyLevel
            chosenSliderPosition = saved.difficultySliderValue
            chosenDifficultValue = saved.difficultyLevelValue
        }
    }
    private func backPressed() {
        navigationController?.popViewController(animated: true)
        saveSettings()
    }
    
    private func podChoice(to direction: podImageChoice) {
        let podImages = PodImages.shared.podArray
        switch direction {
        case .left:
            currentPodIndex = (currentPodIndex - 1 + podImages.count) % podImages.count
            
        case .right:
            currentPodIndex = (currentPodIndex + 1) % podImages.count
        }
        mainPodImage.image = podImages[currentPodIndex].image
        chosenMainPod = podImages[currentPodIndex].name
    }
    
    private func barrierChoice(to direction:barrierImageChoice) {
        let barrierImages = BarrierImages.shared.barrierArray
        switch direction {
        case .left:
            currentBarrierIndex = (currentBarrierIndex - 1 + barrierImages.count) % barrierImages.count
        case .right:
            currentBarrierIndex = (currentBarrierIndex + 1 + barrierImages.count) % barrierImages.count
        }
        barrierImage.image = barrierImages[currentBarrierIndex].image
        chosenBarrier = barrierImages[currentBarrierIndex].name
    }
    
    private func configuratNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
              let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardHeight = keyboardFrame.height
        let userNameMaxY = userName.convert(userName.bounds, to: view).maxY
        let screenHeight = view.frame.height
        let avilableSpace = screenHeight - keyboardHeight
        
        if userNameMaxY > avilableSpace {
            let shift = userNameMaxY - keyboardFrame.minY + 5
            
            sittingsContainer.snp.updateConstraints { make in
                make.top.equalTo(backButton.snp.bottom).inset(shift)
                make.bottom.equalToSuperview().inset(30 + shift)
            }
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            self.backButton.isHidden = true
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        sittingsContainer.snp.updateConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(30)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            self.backButton.isHidden = false
        }
        
    }
    @objc func hideKeyboard() {
        userName.resignFirstResponder()
    }
    
    @objc func difficultyChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        
        let difficultyLevels: [DifficultyLevel] = [.easy, .medium, .hard]
        guard Int(roundedValue) < difficultyLevels.count else { return }
        let selectedDifficulty = difficultyLevels[Int(roundedValue)]
        
        sliderDifficultyLabel.text = selectedDifficulty.rawValue
        chosenDifficultValue = selectedDifficulty.speed
        chosenDifficult = selectedDifficulty.rawValue
        chosenSliderPosition = roundedValue
    }
    
//    @objc func difficultyChanged(_ sender: UISlider) {
//        let roundedValue = round(sender.value)
//        sender.value = roundedValue
//        if roundedValue == 0 {
//            sliderDifficultyLabel.text = "easy"
//        } else if roundedValue == 1 {
//            sliderDifficultyLabel.text = "medium"
//        } else if roundedValue == 2 {
//            sliderDifficultyLabel.text = "hard"
//        }
//        if let text = sliderDifficultyLabel.text {
//            chosenDifficult = text
//        }
//        chosenDifficultValue = roundedValue
//    }
    
    private func saveSettings () {
        
        let savedPlayerSettings = SavedSettins(selectedPod: chosenMainPod ?? Images.mainPod,
                                               barrierName: chosenBarrier ?? Images.firstRock,
                                               playerName: chosenPlayerName ?? "Skywalker",
                                               difficultyLevel: chosenDifficult ?? "Medium",
                                               difficultyLevelValue: chosenDifficultValue ?? 8,
                                               difficultySliderValue: chosenSliderPosition ?? 1
       )
        UserDefaults.standard.set(encodable: savedPlayerSettings, forKey: SettingsKeys.playerSettings)
        
    }
   
}
extension SettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let name = userName.text ?? ""
        guard let stringRange = Range(range, in: name) else { return false }
        let newName = name.replacingCharacters(in: stringRange, with: string)
        chosenPlayerName = newName
        return newName.count <= 10
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        return true
    }
}

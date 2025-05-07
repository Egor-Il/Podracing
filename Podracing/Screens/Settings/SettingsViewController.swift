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
        button.setTitle(SettingsConstants.Strings.back, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: SettingsConstants.Font.fontName, size: SettingsConstants.Font.buttonsSize)
        return button
    }()
    private let settingImageView: UIImageView = {
        let image = UIImageView()
        let settingImage = UIImage(named: SettingsConstants.Strings.settingsPicName)
        image.image = settingImage
        return image
    }()
    private let sittingsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(SettingsConstants.Value.sittingsContainerAlphaComponent)
        view.layer.cornerRadius = SettingsConstants.Layout.sittingsContainerCornerRadius
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
        let button = UIButton(type: .custom)
        let leftChoice = UIImage(named: SettingsConstants.Strings.leftArrow)
        button.setImage(leftChoice, for: .normal)
        return button
    }()
    private let podChoiceRightButton: UIButton = {
        let button = UIButton(type: .custom)
        let rightChoice =  UIImage(named: SettingsConstants.Strings.rightArrow)
        button.setImage(rightChoice, for: .normal)
        return button
    }()
    private var mainPodImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Images.mainPod)   // need to change 
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let podLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsConstants.Strings.selectedPod
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: SettingsConstants.Font.fontName, size: SettingsConstants.Font.buttonsSize)
        return label
    }()
    private let barrierChoiceleftButton: UIButton = {
        let button = UIButton(type: .custom)
        let leftChoice = UIImage(named: SettingsConstants.Strings.leftArrow)
        button.setImage(leftChoice, for: .normal)
        return button
    }()
    private let barrierChoiceRightButton: UIButton = {
        let button = UIButton(type: .custom)
        let rightChoice =  UIImage(named: SettingsConstants.Strings.rightArrow)
        button.setImage(rightChoice, for: .normal)
        return button
    }()
    private let barrierImage: UIImageView = {
        let view = UIImageView()
        let startingBarrier = UIImage(named: SettingsConstants.Strings.stoneOne)
        view.image = startingBarrier
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let barrierLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsConstants.Strings.selectedBarrier
        label.textAlignment = .center
        label.font = UIFont(name: SettingsConstants.Font.fontName, size: SettingsConstants.Font.buttonsSize)
        label.textColor = .black
        return label
    }()
    private let userNameContainer: UIView = {
        let view = UIView()
        return view
    }()
    lazy var userName: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = SettingsConstants.Strings.player  
        textField.delegate = self
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        return textField
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsConstants.Strings.playerName
        label.textAlignment = .center
        label.font = UIFont(name: SettingsConstants.Font.fontName, size: SettingsConstants.Font.buttonsSize)
        label.textColor = .black
        return label
    }()
    
    private  let sliderContainer: UIView = {
        let container = UIView()
        return container
    }()
    private let difficultySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = SettingsConstants.Value.difficultySliderMinValue
        slider.maximumValue = SettingsConstants.Value.difficultySliderMaxValue
        slider.value = SettingsConstants.Value.difficultySliderMidValue
        slider.isContinuous = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .blue
        return slider
    }()
    private let difficultyLevelLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsConstants.Strings.difficultyLevel
        label.textAlignment = .center
        label.font = UIFont(name: SettingsConstants.Font.fontName, size: SettingsConstants.Font.buttonsSize)
        label.textColor = .black
        return label
    }()
    private let sliderDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = SettingsConstants.Strings.medium
        label.textAlignment = .center
        label.font = UIFont(name: SettingsConstants.Font.fontName, size: SettingsConstants.Font.buttonsSize)
        label.textColor = .black
        return label
    }()
    
    private var currentPodIndex = 0 // for extensions?
    private var currentBarrierIndex = 0 // for extensions?
    
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
            case .easy: return SettingsConstants.Value.easySpeed
            case .medium:  return SettingsConstants.Value.mediumSpeed
            case .hard: return SettingsConstants.Value.hardSpeed
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
            make.left.top.equalToSuperview().offset(SettingsConstants.Layout.buttonsOffset)
        }
        sittingsContainer.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.bottom.equalToSuperview().inset(SettingsConstants.Layout.sittingsContainerBottomOffset)
            make.left.equalToSuperview().offset(SettingsConstants.Layout.sittingsContainerLeftRightOffset)
            make.right.equalToSuperview().inset(SettingsConstants.Layout.sittingsContainerLeftRightOffset)
        }
        podSettingsContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(SettingsConstants.Layout.multiplierForSettingsContainer)
        }
        podChoiceleftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(SettingsConstants.Layout.choiceRightLeftButtonOffset)
            make.width.height.equalTo(SettingsConstants.Layout.buttonsHeight)
        }
        podChoiceRightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(SettingsConstants.Layout.choiceRightLeftButtonOffset)
            make.width.height.equalTo(SettingsConstants.Layout.buttonsHeight)
        }
        podLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(SettingsConstants.Layout.podLabelTopOffset)
            make.left.equalTo(podChoiceleftButton.snp.right)
            make.right.equalTo(podChoiceRightButton.snp.left)
            make.height.equalTo(SettingsConstants.Layout.podLabelHeight)
        }
        mainPodImage.snp.makeConstraints { make in
            make.top.equalTo(podLabel.snp.bottom).offset(SettingsConstants.Layout.mainPodImageTopBottomOffset)
            make.left.equalTo(podChoiceleftButton.snp.right)
            make.right.equalTo(podChoiceRightButton.snp.left)
            make.bottom.equalToSuperview().inset(SettingsConstants.Layout.mainPodImageTopBottomOffset)
        }
        barrierSettingsContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(podSettingsContainer.snp.bottom)
            make.height.equalToSuperview().multipliedBy(SettingsConstants.Layout.multiplierForSettingsContainer)
        }
        barrierChoiceleftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(SettingsConstants.Layout.buttonsHeight)
        }
        barrierChoiceRightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.height.equalTo(SettingsConstants.Layout.buttonsHeight)
        }
        barrierLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(SettingsConstants.Layout.barrierLabelTopOffset)
            make.left.equalTo(barrierChoiceleftButton.snp.right)
            make.right.equalTo(barrierChoiceRightButton.snp.left)
            make.height.equalTo(SettingsConstants.Layout.barrierLabelHeight)
        }
        barrierImage.snp.makeConstraints { make in
            make.top.equalTo(barrierLabel.snp.bottom).offset(SettingsConstants.Layout.barrierImageTopBottomOffset)
            make.left.equalTo(barrierChoiceleftButton.snp.right)
            make.right.equalTo(barrierChoiceRightButton.snp.left)
            make.bottom.equalToSuperview().inset(SettingsConstants.Layout.barrierImageTopBottomOffset)
        }
        userNameContainer.snp.makeConstraints { make in
            make.top.equalTo(barrierSettingsContainer.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(SettingsConstants.Layout.multiplierForUserNameContainer)
        }
        userName.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(SettingsConstants.Layout.multiplierForUserName)
            make.left.equalToSuperview().offset(SettingsConstants.Layout.userNameLeftRightOffset)
            make.right.equalToSuperview().inset(SettingsConstants.Layout.userNameLeftRightOffset)
        }
        userNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(userName.snp.top).offset(-SettingsConstants.Layout.userNameLeftRightOffset)
        }
        sliderContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(userNameContainer.snp.bottom)
            make.bottom.equalToSuperview()
        }
        difficultySlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(SettingsConstants.Layout.difficultySliderLeftRightOffset)
            make.right.equalToSuperview().inset(SettingsConstants.Layout.difficultySliderLeftRightOffset)
            make.centerY.equalToSuperview()
        }
        sliderDifficultyLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(difficultySlider.snp.bottom)
        }
        difficultyLevelLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(difficultySlider.snp.top).offset(-SettingsConstants.Layout.difficultyLevelLabelBottomOffset)
        }
    }
    
    private func reloadSettings() {
        guard let savedSettings = UserDefaults.standard.value(SavedSettins.self, forKey: SettingsConstants.userDefaults.playerSettings) else { return }
        mainPodImage.image = UIImage(named: savedSettings.selectedPod)
        barrierImage.image = UIImage(named: savedSettings.barrierName)
        userName.text = savedSettings.playerName
        sliderDifficultyLabel.text = savedSettings.difficultyLevel
        difficultySlider.value = chosenSliderPosition ?? SettingsConstants.Value.difficultySliderMidValue
    }
    
    private func preLoadSavedSettings() {
        if let saved = UserDefaults.standard.value(SavedSettins.self, forKey: SettingsConstants.userDefaults.playerSettings) {
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
            let shift = userNameMaxY - keyboardFrame.minY + SettingsConstants.Layout.keyboardWillShowOffsetBetweenKeyboardAndTextfield
            
            sittingsContainer.snp.updateConstraints { make in
                make.top.equalTo(backButton.snp.bottom).inset(shift)
                make.bottom.equalToSuperview().inset(SettingsConstants.Layout.keyboardWillShowSittings + shift)
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
            make.top.equalTo(backButton.snp.bottom).offset(SettingsConstants.Layout.keyboardWillHideTop)
            make.bottom.equalToSuperview().inset(SettingsConstants.Layout.keyboardWillHideBottom)
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
        if chosenPlayerName?.isEmpty ?? true {
            chosenPlayerName = SettingsConstants.Strings.defaultName
        }
        let savedPlayerSettings = SavedSettins(selectedPod: chosenMainPod ?? SettingsConstants.Strings.defaultPod,
                                               barrierName: chosenBarrier ?? Images.firstRock,     // will replaced for track chose
                                               playerName: chosenPlayerName ?? SettingsConstants.Strings.defaultName,
                                               difficultyLevel: chosenDifficult ?? SettingsConstants.Strings.medium,
                                               difficultyLevelValue: chosenDifficultValue ?? DifficultyLevel.medium.speed ,
                                               difficultySliderValue: chosenSliderPosition ?? SettingsConstants.Value.difficultySliderMidValue
       )
        UserDefaults.standard.set(encodable: savedPlayerSettings, forKey: SettingsConstants.userDefaults.playerSettings)
    }
}
// MARK: - Extension 
extension SettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let name = userName.text ?? SettingsConstants.Strings.defaultName
        guard let stringRange = Range(range, in: name) else { return false }
        let newName = name.replacingCharacters(in: stringRange, with: string)
        chosenPlayerName = newName
        return newName.count <= 10 // Maximum number of characters for a username
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        return true
    }
}

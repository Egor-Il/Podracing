//
//  SettingsViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
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
    private let placeForSittings: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.8
        view.layer.cornerRadius = 10
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
    private var podImage: UIImageView = {
        let view = UIImageView()
        // let startingPod = UIImage(named: "mainPod")
        view.contentMode = .scaleAspectFit
        return view
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
    lazy var userName: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "Player"
        textField.delegate = self
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var currentPodIndex = 0
    private var currentBarrierIndex = 0
    private var currentPlayerName = "player"
    
    enum podLookChoice{
        case left
        case right
    }
    enum barrierLookChoice{
        case left
        case right
    }
    // MARK: - life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configuratSettingUI()
    }
    // MARK: - UI configutarion
    private func configuratSettingUI() {
        load()
        configuratNotifications()
        view.addSubview(settingImageView)
        view.addSubview(backButton)
        view.addSubview(placeForSittings)
        placeForSittings.addSubview(podSettingsContainer)
        podSettingsContainer.addSubview(podChoiceleftButton)
        podSettingsContainer.addSubview(podChoiceRightButton)
        podSettingsContainer.addSubview(podImage)
        placeForSittings.addSubview(barrierSettingsContainer)
        barrierSettingsContainer.addSubview(barrierChoiceleftButton)
        barrierSettingsContainer.addSubview(barrierChoiceRightButton)
        barrierSettingsContainer.addSubview(barrierImage)
        placeForSittings.addSubview(userName)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        // MARK: - Setting view constraints
        settingImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonOffSet)
        }
        placeForSittings.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(30)
        }
        podSettingsContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            let containerHeight = podSettingsContainer.frame.height / 4
            print(containerHeight)
            make.height.equalTo(200)
        }
        podChoiceleftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        podChoiceRightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        podImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(podChoiceleftButton.snp.right).offset(5)
            make.right.equalTo(podChoiceRightButton.snp.left).offset(5) // test
            make.bottom.equalToSuperview().inset(5)
        }
        barrierSettingsContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(podSettingsContainer.snp.bottom)
            make.height.equalTo(200)
        }
        barrierChoiceleftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        barrierChoiceRightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        barrierImage.snp.makeConstraints { make in
            make.top.equalTo(podSettingsContainer.snp.bottom).offset(5)
            make.left.equalTo(barrierChoiceleftButton.snp.right).offset(5)
            make.right.equalTo(barrierChoiceRightButton.snp.left).offset(5) // test
            make.bottom.equalToSuperview().inset(5)
        }
        userName.snp.makeConstraints { make in
            make.top.equalTo(barrierSettingsContainer.snp.bottom).offset(10)
            
            make.left.right.equalToSuperview().inset(10)
        }
        // MARK: - Buttons setup
        let firstPodImage = PodImages.shared?.podArray[currentPodIndex]
        podImage.image = firstPodImage
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
    }
    // MARK: - Functions
    private func backPressed() {
        navigationController?.popViewController(animated: true)
        save()
    }
    private func podChoice(to direction: podLookChoice) {
        guard let podImages = PodImages.shared?.podArray else { return }
        switch direction {
        case .left:  // - переделать нормальный енам
            currentPodIndex = (currentPodIndex - 1 + podImages.count) % podImages.count
            
        case .right:
            currentPodIndex = (currentPodIndex + 1) % podImages.count
        }
        podImage.image = podImages[currentPodIndex]
    }
    private func barrierChoice(to direction:barrierLookChoice) {
        guard let barrierImages = BarrierImages.shared?.barrierArray else { return }
        switch direction {
        case .left:
            currentBarrierIndex = (currentBarrierIndex - 1 + barrierImages.count) % barrierImages.count
        case .right:
            currentBarrierIndex = (currentBarrierIndex + 1 + barrierImages.count) % barrierImages.count
        }
        barrierImage.image = barrierImages[currentBarrierIndex]
    }
    private func save() {
        
       /* let savedPod = PodImages.shared?.podArray[currentPodIndex]*/ // не помню зачем
//        print(savedPod as Any)
        UserDefaults.standard.setValue(currentPodIndex, forKey: SettingsKeys.pod)
        UserDefaults.standard.setValue(currentBarrierIndex, forKey: SettingsKeys.barrier)
        UserDefaults.standard.setValue(currentPlayerName, forKey: SettingsKeys.playerName)
        print("end save")
        // - сохранять одной строчкой?
        
        print(
            UserDefaults.standard.value(forKey: SettingsKeys.pod)!,
            UserDefaults.standard.value(forKey: SettingsKeys.barrier)!,
            UserDefaults.standard.value(forKey: SettingsKeys.playerName)!
        )
    }
    private func load() {
        
        UserDefaults.standard.setValue(currentPodIndex, forKey: SettingsKeys.pod)
        UserDefaults.standard.setValue(currentBarrierIndex, forKey: SettingsKeys.barrier)
        UserDefaults.standard.setValue(currentPlayerName, forKey: SettingsKeys.playerName)
        print("end load")
    }
    
    private func configuratNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
              /*let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue*/
        placeForSittings.snp.updateConstraints { make in
            make.top.equalTo(backButton.snp.bottom).inset(25)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            self.backButton.isHidden = true
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        placeForSittings.snp.updateConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            self.backButton.isHidden = false
        }
    }
    @objc func hideKeyboard() {
        userName.resignFirstResponder()
    }
}
extension SettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let name = userName.text ?? ""
        guard let stringRange = Range(range, in: name) else { return false }
        let newName = name.replacingCharacters(in: stringRange, with: string)
        currentPlayerName = newName
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        return true
    }
}

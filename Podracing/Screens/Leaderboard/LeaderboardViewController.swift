//
//  LeaderboardViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

final class LeaderboardViewController: UIViewController {
    // MARK: - Property
    private let leaderboardImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let buttonBack: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LeaderboardConstants.Strings.back, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.buttonBackFontSize)
        return button
    }()
    
    private let buttonClear: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LeaderboardConstants.Strings.clear, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.buttonClearFontSize)
        return button
    }()
    
    private let leaderboardHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = LeaderboardConstants.Value.cornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    var headerTextRecord: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.headerFontSize)
        label.text = LeaderboardConstants.Strings.record
        label.textColor = .black
        return label
    }()
    
    var headerTextName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.headerFontSize)
        label.text = LeaderboardConstants.Strings.name
        label.textColor = .black
        return label
    }()
    
    var headerTextDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.headerFontSize)
        label.text = LeaderboardConstants.Strings.date
        label.textColor = .black
        return label
    }()
    
    private lazy var scoreTable: UITableView = {
        let table = UITableView()
        table.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLeaderboardUI()
    }
    // MARK: - Func Actions
    private func configureLeaderboardUI() {
        view.addSubview(leaderboardImage)
        view.addSubview(buttonBack)
        view.addSubview(buttonClear)
        view.addSubview(scoreTable)
        view.addSubview(leaderboardHeader)
        
        leaderboardHeader.addSubview(headerTextRecord)
        leaderboardHeader.addSubview(headerTextName)
        leaderboardHeader.addSubview(headerTextDate)
        
        let  boardImage = UIImage(named: LeaderboardConstants.Strings.leaderboardPicName)
        leaderboardImage.image = boardImage
        
        setupConstraints()
        
        let backfromBoardAction = UIAction { _ in
            self.backButtonPressed()
        }
        let clearLeaderboardAction = UIAction { _ in
            self.clearButtonPressed()
        }
        buttonBack.addAction(backfromBoardAction, for: .touchUpInside)
        buttonClear.addAction(clearLeaderboardAction, for: .touchUpInside)
    }
    
    private func setupConstraints()  {
        leaderboardImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        buttonBack.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(LeaderboardConstants.Layout.buttonsOffset)
        }
        buttonClear.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LeaderboardConstants.Layout.buttonsOffset)
            make.right.equalToSuperview().inset(LeaderboardConstants.Layout.buttonsOffset)
        }
        leaderboardHeader.snp.makeConstraints { make in
            make.top.equalTo(buttonBack.snp.bottom).offset(LeaderboardConstants.Layout.headerTopOffset)
            make.left.equalToSuperview().offset(LeaderboardConstants.Layout.headerLeftRightOffset)
            make.right.equalToSuperview().inset(LeaderboardConstants.Layout.headerLeftRightOffset)
            make.height.equalTo(LeaderboardConstants.Layout.headerHeight)
        }
        headerTextName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(LeaderboardConstants.Layout.headerNameOffset)
            make.width.equalToSuperview().dividedBy(3)
            make.centerY.equalToSuperview()
        }
        headerTextRecord.snp.makeConstraints { make in
            make.left.equalTo(headerTextName.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.centerY.equalToSuperview()
        }
        headerTextDate.snp.makeConstraints { make in
            make.left.equalTo(headerTextRecord.snp.right)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        scoreTable.snp.makeConstraints { make in
            make.top.equalTo(leaderboardHeader.snp.bottom)
            make.left.equalToSuperview().offset(LeaderboardConstants.Layout.scoreLabelLeftRightOffset)
            make.right.equalToSuperview().inset(LeaderboardConstants.Layout.scoreLabelLeftRightOffset)
            make.bottom.equalToSuperview()
        }
        scoreTable.bounces = false
        scoreTable.alwaysBounceVertical = false
    }
    
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    private func clearButtonPressed() {
        LeaderboardManager.shared.clearRecord()
        scoreTable.reloadData()
    }
    // MARK: - Extension
}
extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LeaderboardManager.shared.getRecord().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.identifier, for: indexPath) as? LeaderboardTableViewCell else {
            return UITableViewCell()
        }
        
        let entry = LeaderboardManager.shared.getRecord()[indexPath.row]
        cell.configure(with: entry)
        return cell
    }
}

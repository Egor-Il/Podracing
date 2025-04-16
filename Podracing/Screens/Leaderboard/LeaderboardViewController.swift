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
        button.setTitle(Buttons.buttonBackLable, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return button
    }()
    private let buttonClear: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.fontName, size: Font.buttonBackFontSize)
        return button
    }()
    private let leaderboardHeader: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    var headerTextRecord: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: 16)
        label.textColor = .black
        return label
    }()
    var headerTextName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: 16)
        label.textColor = .black
        return label
    }()
    var headerTextDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Font.fontName, size: 16)
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
        
      
        // table.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) // - полоса разделения
        return table
    }()
    // MARK: - Another step
    override func viewDidLoad() {
        super.viewDidLoad()
        configuratLeaderBoardUI()
    }
    private func configuratLeaderBoardUI() {
        view.addSubview(leaderboardImage)
        view.addSubview(buttonBack)
        view.addSubview(buttonClear)
        view.addSubview(scoreTable)
        view.addSubview(leaderboardHeader)
        
        leaderboardHeader.addSubview(headerTextRecord)
        leaderboardHeader.addSubview(headerTextName)
        leaderboardHeader.addSubview(headerTextDate)
        let  boardImage = UIImage(named: Images.leaderboard)
        leaderboardImage.image = boardImage
        
        setupConstraints()
        // MARK: - Property Constraints
        
        // MARK: - Buttons setup
        let backfromBoardAction = UIAction { _ in
            self.backButtonPressed()
        }
        let clearLeaderboardAction = UIAction { _ in
            self.clearButtonPressed()
        }
        buttonBack.addAction(backfromBoardAction, for: .touchUpInside)
        buttonClear.addAction(clearLeaderboardAction, for: .touchUpInside)
    }
    // MARK: - Functions
    
    private func setupConstraints()  {
        leaderboardImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        buttonBack.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Buttons.buttonOffSet)
        }
        buttonClear.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Buttons.buttonOffSet)
            make.right.equalToSuperview().inset(Buttons.buttonOffSet)
        }
        leaderboardHeader.snp.makeConstraints { make in
            make.top.equalTo(buttonBack.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        headerTextName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
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
        headerTextRecord.text = "Record"
        headerTextName.text = "Name"
        headerTextDate.text = "Date"
        scoreTable.snp.makeConstraints { make in
            make.top.equalTo(leaderboardHeader.snp.bottom)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
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
//        cell.contentView.backgroundColor = .clear
//        cell.backgroundColor = .gray
        
        return cell
    }
    
    
}

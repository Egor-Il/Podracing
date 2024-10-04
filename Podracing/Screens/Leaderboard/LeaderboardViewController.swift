//
//  LeaderboardViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 5/3/24.
//

import UIKit
import SnapKit

class LeaderboardViewController: UIViewController {
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
       // view.alpha = 0.5
       // view.layer.cornerRadius = 20
        return view
    }()
    var headerTextRecord: UILabel = {
        let label = UILabel()
       // label.textAlignment = .center
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
     //   label.textAlignment = .center
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
       // view.backgroundColor = .lightGray
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
        // MARK: - Property Constraints
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
        headerTextRecord.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
            //make.centerX.equalToSuperview()
        }
        headerTextName.snp.makeConstraints { make in
            make.left.equalTo(headerTextRecord.snp.right)
            make.right.equalTo(headerTextDate.snp.left)
            make.centerY.equalToSuperview()
          //  make.centerX.equalToSuperview()
        }
        headerTextDate.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
          //  make.centerX.equalToSuperview()
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
        // MARK: - Buttons setup
        let backfromBoardAction = UIAction { _ in
            self.backButtonPressed()
        }
        let clearLeaderboardAction = UIAction { _ in
            self.clearButtonPressed()
        }
        buttonBack.addAction(backfromBoardAction, for: .touchUpInside)
        buttonClear.addAction(clearLeaderboardAction, for: .touchUpInside)
       // recordTime()
    }
    // MARK: - Functions
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    private func clearButtonPressed() {     // - надо доделать очистку таблицы. очистку ячеек
        LeaderboardData().clearRecords()
      //  print(LeaderboardData.LeaderboardDataArray)
    }
    
//    func recordTime() {
//        let savedDate = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM d, yyyy, HH:mm"
//        let savedRaceDate = formatter.string(from: savedDate)
//        print(savedRaceDate)
//       leaderboardText.text = "1 - \(savedRaceDate)"
//    }
    

    // MARK: - Extension
}
extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource  {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    leaderboardContent.count
      //  LeaderboardData.LeaderboardDataArray.count
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.identifier, for: indexPath) as? LeaderboardTableViewCell else {
            return UITableViewCell()
        }
        
        //cell.fillRaceResuld(recordInfo: LeaderboardManager(raceRecord: "23424", playerName: "Egor", recordDate: "21.21.12"))
        cell.contentView.backgroundColor = .clear
       // cell.backgroundColor = .clear // - фон ячейки
        return cell
    }
    
    
}

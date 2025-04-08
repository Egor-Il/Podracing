//
//  LeaderboardTableViewCell.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/24/24.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    
    private let record: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Starjedi", size: 15)
        return label
    }()
    private let playerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Starjedi", size: 15)
        label.textAlignment = .center
        return label
    }()
    private let recordDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Starjedi", size: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(record)
        contentView.addSubview(playerName)
        contentView.addSubview(recordDate)
        
        record.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        recordDate.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        playerName.snp.makeConstraints { make in
            make.left.equalTo(record.snp.right)
            make.right.equalTo(recordDate.snp.left)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func fillRaceResuld(){
        record.text = LeaderboardManager.shared.getRecord().first?.record
        playerName.text = LeaderboardManager.shared.getRecord().first?.player
        recordDate.text = LeaderboardManager.shared.getRecord().first?.date
    }
}

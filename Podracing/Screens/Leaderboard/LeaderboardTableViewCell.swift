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
        label.textAlignment = .center
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
        label.textAlignment = .center
        label.font = UIFont(name: "Starjedi", size: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(playerName)
        contentView.addSubview(record)
        contentView.addSubview(recordDate)
        
        playerName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.width.equalToSuperview().dividedBy(3)
            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview()
        }
        record.snp.makeConstraints { make in
            make.left.equalTo(playerName.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview()
        }
        recordDate.snp.makeConstraints { make in
            make.left.equalTo(record.snp.right)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with entry: LeaderboardEntry) {
        record.text = String(entry.record)
        playerName.text = entry.player
        recordDate.text = entry.date
    }
}

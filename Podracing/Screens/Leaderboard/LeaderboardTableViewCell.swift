//
//  LeaderboardTableViewCell.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/24/24.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    
    static var identifier: String {"\(Self.self)"}
    // MARK: - Property
    private let record: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.recordFontSize)
        label.textAlignment = .center
        return label
    }()
    private let playerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.recordFontSize)
        label.textAlignment = .center
        return label
    }()
    private let recordDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: LeaderboardConstants.Font.fontName, size: LeaderboardConstants.Font.recordFontSize)
        return label
    }()
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    // MARK: - Cell sutup 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.insertSubview(blurView, at: 0)
        contentView.addSubview(playerName)
        contentView.addSubview(record)
        contentView.addSubview(recordDate)
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        playerName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(LeaderboardConstants.Layout.playerNameOffset)
            make.width.equalToSuperview().dividedBy(3)
            make.centerY.equalToSuperview()
        }
        record.snp.makeConstraints { make in
            make.left.equalTo(playerName.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.centerY.equalToSuperview()
        }
        recordDate.snp.makeConstraints { make in
            make.left.equalTo(record.snp.right)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
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

//
//  SettingTableViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/18/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let id = "SettingTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

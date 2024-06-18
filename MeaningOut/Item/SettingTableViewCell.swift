//
//  SettingTableViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/18/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    static let id = "SettingTableViewCell"
    
    let label = UILabel()
    let likeLabel = UILabel()
    let shopImage = UIImageView()
    let ud = UserDefaultManager()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(likeLabel)
        contentView.addSubview(shopImage)
        shopImage.image = UIImage(named: "like_selected")
        likeLabel.text = "\(SearchViewController.productId.count)개의 상품"
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(25)
        }
        shopImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(likeLabel.snp.leading)
            make.size.equalTo(25)
        }
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

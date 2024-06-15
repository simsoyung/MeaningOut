//
//  SearchTableViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit
import SnapKit
class SearchTableViewCell: UITableViewCell {
    
    static let id = "SearchTableViewCell"
    
    let imageLabel = UIImageView()
    let wordLabel = UILabel()
    let cancelButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: TextResource.SystemImageName.xmark.rawValue), for: .normal)
        bt.tintColor = UIColor(cgColor: TextResource.ColorRGB.blackCG)
        return bt
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        contentView.addSubview(imageLabel)
        contentView.addSubview(wordLabel)
        contentView.addSubview(cancelButton)
    }
    func configureLayout(){
        imageLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(20)
        }
        wordLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(imageLabel.snp.trailing).offset(20)
            make.height.equalTo(20)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
    }
    func configureUI(){
        imageLabel.clockLabel()
        wordLabel.wordListLabel()
    }
    func configureCell(list: String){
        wordLabel.text = list
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

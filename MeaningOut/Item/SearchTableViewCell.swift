//
//  SearchTableViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let id = "SearchTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){}
    func configureLayout(){}
    func configureUI(){
        contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

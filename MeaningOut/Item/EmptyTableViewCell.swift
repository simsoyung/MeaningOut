//
//  EmptyTableViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/15/24.
//

import UIKit
import SnapKit

class EmptyTableViewCell: UITableViewCell {

    static let id = "EmptyTableViewCell"
    
    let emptyView = UIImageView()
    let emptyLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        contentView.addSubview(emptyView)
        contentView.addSubview(emptyLable)
    }
    func configureLayout(){
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        emptyLable.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).inset(100)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
    }
    func configureUI(){
        emptyView.contentMode = .scaleAspectFit
        emptyView.image = UIImage(named: "empty")
        emptyLable.emptyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

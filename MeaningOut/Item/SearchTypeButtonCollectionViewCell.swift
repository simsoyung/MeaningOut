//
//  SearchTypeButtonCollectionViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/17/24.
//

import UIKit

class SearchTypeButtonCollectionViewCell: UICollectionViewCell {
    static let id = "SearchTypeButtonCollectionViewCell"
    
    let colorView = UIView()
    let typeLabel = UILabel()
    
    var clickCount: Int = 0 {
        didSet {
            if clickCount == 0 {
                colorView.backgroundColor = TextResource.ColorRGB.darkGrayUI
                typeLabel.textColor = TextResource.ColorRGB.whiteUI
                layer.borderWidth = 1
                layer.borderColor = TextResource.ColorRGB.darkGrayCG
                layer.cornerRadius = 10
                clipsToBounds = true
                typeLabel.textAlignment = .center
                typeLabel.font = .systemFont(ofSize: 13, weight: .bold)
            } else {
                colorView.backgroundColor = TextResource.ColorRGB.whiteUI
                typeLabel.textColor = TextResource.ColorRGB.blackUI
                layer.cornerRadius = 10
                clipsToBounds = true
                typeLabel.textAlignment = .center
                typeLabel.font = .systemFont(ofSize: 13, weight: .bold)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                colorView.backgroundColor = TextResource.ColorRGB.whiteUI
                typeLabel.textColor = TextResource.ColorRGB.blackUI
                clickCount = 0
                layer.cornerRadius = 10
                clipsToBounds = true
                typeLabel.textAlignment = .center
                typeLabel.font = .systemFont(ofSize: 13, weight: .bold)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(colorView)
        contentView.addSubview(typeLabel)
        typeLabel.text = "dddd"
        colorView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        typeLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.top.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

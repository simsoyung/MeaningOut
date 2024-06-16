//
//  SearchTypeButton.swift
//  MeaningOut
//
//  Created by 심소영 on 6/17/24.
//

import UIKit

class SearchTypeButton: UIButton {
    
    init(type: String  ){
        super.init(frame: .zero)
        setTitle(type, for: .normal)
        setTitleColor(TextResource.ColorRGB.darkGrayUI, for: .normal)
        layer.cornerRadius = 15
        titleLabel?.textAlignment = .center
        titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        layer.borderWidth = 1
        layer.borderColor = TextResource.ColorRGB.darkGrayCG
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

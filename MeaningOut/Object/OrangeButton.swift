//
//  OrangeButton.swift
//  MeaningOut
//
//  Created by 심소영 on 6/13/24.
//

import UIKit

class OrangeButton: UIButton {
    init(title: TextResource.ButtonText){
        super.init(frame: .zero)
        setTitle(title.rawValue, for: .normal)
        setTitleColor(TextResource.ColorRGB.whiteUI, for: .normal)
        backgroundColor = TextResource.ColorRGB.orangeUI
        layer.cornerRadius = 20
        titleLabel?.textAlignment = .center
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


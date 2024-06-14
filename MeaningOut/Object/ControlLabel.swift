//
//  ControlLabel.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit

class ControlLabel: UILabel {
    init(titleText: TextResource.LabelText) {
        super.init(frame: .zero)
        text = TextResource.LabelText.nicknameCountLabelFalse.rawValue
        backgroundColor = .white
        textColor = TextResource.ColorRGB.orangeUI
        font = .boldSystemFont(ofSize: 13)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

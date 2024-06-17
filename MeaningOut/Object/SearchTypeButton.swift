//
//  SearchTypeButton.swift
//  MeaningOut
//
//  Created by 심소영 on 6/17/24.
//

import UIKit

class SearchTypeButton: UIButton {
    
    init(type: String, selected: Bool){
        super.init(frame: .zero)
        if selected {
            setTitleColor(TextResource.ColorRGB.whiteUI, for: .selected)
            backgroundColor = TextResource.ColorRGB.darkGrayUI
        } else {
            setTitleColor(TextResource.ColorRGB.darkGrayUI, for: .normal)
            backgroundColor = TextResource.ColorRGB.whiteUI
        }
        setTitle(type, for: .normal)
        titleLabel?.textAlignment = .center
        titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        layer.borderWidth = 1
        layer.cornerRadius = 15
        layer.borderColor = TextResource.ColorRGB.darkGrayCG
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIButton.Configuration {
    static func typeStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        return configuration
    }
}


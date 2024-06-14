//
//  CameraButton.swift
//  MeaningOut
//
//  Created by 심소영 on 6/13/24.
//

import UIKit

class CameraButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bt = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        setImage(UIImage(systemName: TextResource.SystemImageName.camera.rawValue, withConfiguration: bt), for: .normal)
        backgroundColor = TextResource.ColorRGB.orangeUI
        tintColor = TextResource.ColorRGB.whiteUI
        contentMode = .scaleAspectFit
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

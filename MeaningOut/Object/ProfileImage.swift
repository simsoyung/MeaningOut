//
//  ProfileImage.swift
//  MeaningOut
//
//  Created by 심소영 on 6/13/24.
//

import UIKit

class ProfileImage: UIImageView {
    
    let ud = UserDefaultManager()
    static let randomImage = ["profile_0","profile_1","profile_2","profile_3", "profile_4", "profile_5", "profile_6", "profile_7", "profile_8", "profile_9", "profile_10","profile_11"]
    
    init(imageAlpha: CGFloat, radius: CGFloat, bordercolor: CGColor, width: CGFloat ){
        super.init(frame: .zero)
        image = UIImage(named: ProfileImage.randomImage.randomElement() ?? "profile_0")
        contentMode = .scaleAspectFit
        layer.cornerRadius = radius
        clipsToBounds = true
        layer.masksToBounds = true
        alpha = imageAlpha
        layer.borderColor = bordercolor
        layer.borderWidth = width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

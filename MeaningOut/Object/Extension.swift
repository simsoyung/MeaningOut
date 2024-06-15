//
//  Extension.swift
//  MeaningOut
//
//  Created by 심소영 on 6/15/24.
//

import UIKit

extension UILabel {
    func emptyLabel(){
        self.text = TextResource.LabelText.wordNothing.rawValue
        self.font = .boldSystemFont(ofSize: 15)
        self.textAlignment = .center
    }
    
    func headerLabel(){
        self.text = TextResource.LabelText.recentWord.rawValue
        self.textAlignment = .left
        self.textColor = TextResource.ColorRGB.blackUI
        self.font = .boldSystemFont(ofSize: 14)
    }
    func wordListLabel(){
        self.textAlignment = .left
        self.textColor = TextResource.ColorRGB.blackUI
        self.font = .systemFont(ofSize: 13, weight: .regular)
    }
}

extension UIButton {
    func deleteBt(){
        self.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        self.titleLabel?.textAlignment = .right
        self.setTitle(TextResource.LabelText.deleteBt.rawValue, for: .normal)
        self.setTitleColor(TextResource.ColorRGB.orangeUI, for: .normal)
    }
    
}

extension UIImageView {
    func clockLabel(){
        self.image = UIImage(systemName: TextResource.SystemImageName.clock.rawValue)
        self.tintColor = TextResource.ColorRGB.blackUI
    }
}

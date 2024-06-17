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
    func mallLabel(){
        self.textAlignment = .left
        self.textColor = TextResource.ColorRGB.grayUI
        self.font = .systemFont(ofSize: 13, weight: .heavy)
    }
    func storeSubLabel(){
        self.textAlignment = .left
        self.textColor = TextResource.ColorRGB.blackUI
        self.font = .systemFont(ofSize: 13, weight: .heavy)
        self.numberOfLines = 2
    }
    func priceLabel(){
        self.textAlignment = .left
        self.textColor = TextResource.ColorRGB.blackUI
        self.font = .boldSystemFont(ofSize: 14)
    }
    
}

extension UIButton {
    func deleteBt(){
        self.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        self.titleLabel?.textAlignment = .right
        self.setTitle(TextResource.LabelText.deleteBt.rawValue, for: .normal)
        self.setTitleColor(TextResource.ColorRGB.orangeUI, for: .normal)
    }
    func shopBt(like: Bool){
        self.setImage(UIImage(named: "like_unselected"), for: .normal)
        self.layer.cornerRadius = 5
        self.backgroundColor = TextResource.ColorRGB.grayUI
        self.alpha = 0.8
        
    }
    
}
extension UIImageView {
    func clockLabel(){
        self.image = UIImage(systemName: TextResource.SystemImageName.clock.rawValue)
        self.tintColor = TextResource.ColorRGB.blackUI
    }
    
    func settingImage(){
        self.image = UIImage(named: ProfileImage.randomImage.randomElement() ?? "profile_0")
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 50
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderColor = TextResource.ColorRGB.orangeCG
        self.layer.borderWidth = 3
    }
}

extension String {
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData,
                                                    options: options,
                                                    documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

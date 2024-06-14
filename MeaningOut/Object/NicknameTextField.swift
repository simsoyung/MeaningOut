//
//  NicknameTextField.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit

class NicknameTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        placeholder = TextResource.TextFieldPlaceholder.nickname.rawValue
        backgroundColor = .white
        borderStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor){
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 10, width: viewSize - 44, height: width)
        border.borderWidth  = width
        self.layer.addSublayer(border)
    }
}

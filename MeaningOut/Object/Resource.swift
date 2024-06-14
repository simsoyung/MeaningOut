//
//  Resource.swift
//  MeaningOut
//
//  Created by 심소영 on 6/13/24.
//

import UIKit

enum TextResource {
    enum ButtonText: String {
        case start = "시작하기"
        case finish = "완료"
        case tabBarSearch = "검색"
        case tabBarSetting = "설정"
    }
    
    enum NaviText: String {
        case profile = "PROFILE SETTING"
        case userIDtext = "'s MEANING OUT"
    }
    
    enum SystemImageName: String {
        case chevron = "chevron.left"
        case camera = "camera.fill"
        case magnifyingglass
        case clock
        case person
        case xmark
    }
    
    enum ColorRGB {
        static let orangeUI = UIColor(red: 239/255, green: 137/255, blue: 71/255, alpha: 1.0)
        static let orangeCG = CGColor(red: 239/255, green: 137/255, blue: 71/255, alpha: 1.0)
        static let blackUI = UIColor.black
        static let blackCG = CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        static let grayUI = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
        static let grayCG = CGColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
        static let darkGrayUI = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
        static let darkGrayCG = CGColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0)
        static let lightGrayUI = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1.0)
        static let lightGrayCG = CGColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1.0)
        static let whiteUI = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        static let whiteCG = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }
    
    enum TextFieldPlaceholder: String {
        case nickname = "닉네임을 입력해주세요 :)"
        case search = "브랜드. 상품 등을 입력하세요"
    }
    
    enum LabelText: String {
        case nicknameDefalut = "닉네임을 입력해주세요 :)"
        case nicknameCountLabelFalse = "2글자 이상 10글자 미만으로 설정해주세요"
        case nicknameCountLabelTrue = "사용할 수 있는 닉네임이에요 :D"
        case nicknameNumFalse = "닉네임에 숫자는 포함할 수 없어요"
        case nicknameCharFalse = "닉네임에 @, #, $, % 는 포함할 수 없어요"
    }
}

//
//  UserDefaults.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit

class UserDefaultManager {
    var imageIndex: String{
        get{
            return UserDefaults.standard.string(forKey: "imageNum") ?? "0"
        }
        set{
            UserDefaults.standard.set("profile_\(newValue)", forKey: "imageNum")
        }
    }
    
    var nickname: String{
        get{
            return UserDefaults.standard.string(forKey: "nickname") ?? "새콤달콤"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var searchWord: String{
        get{
            return UserDefaults.standard.string(forKey: "word") ?? "강아지"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "word")
        }
    }
}

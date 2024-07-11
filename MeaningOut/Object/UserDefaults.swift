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
            return UserDefaults.standard.string(forKey: "imageNum") ?? ""
        }
        set{
            UserDefaults.standard.set("profile_\(newValue)", forKey: "imageNum")
        }
    }
    
    var date: String{
        get{
            return UserDefaults.standard.string(forKey: "date") ?? ""
        }
        set{
            UserDefaults.standard.set("\(newValue) 가입", forKey: "date")
        }
    }
    var word: [String]?{
        get{
            return UserDefaults.standard.stringArray(forKey: "word")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "word")
        }
    }
    
    var nickname: String{
        get{
            return UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var productName: String {
        get{
            return UserDefaults.standard.string(forKey: "productName") ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "productName")
        }
    }
    
    var url: String {
        get{
            return UserDefaults.standard.string(forKey: "url") ?? ""
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "url")
        }
    }
    
    var id: [String]? {
        get{
            return UserDefaults.standard.stringArray(forKey: "id") 
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "id")
        }
    }
    
    var word: [String]? {
        get{
            return UserDefaults.standard.stringArray(forKey: "word")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "word")
        }
    }
    
    var like: Bool {
        get{
            return UserDefaults.standard.bool(forKey: "like")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "like")
        }
    }
    var type: String? {
        get{
            return UserDefaults.standard.string(forKey: "type")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "type")
        }
    }
    
}


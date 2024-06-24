//
//  NaveManager.swift
//  MeaningOut
//
//  Created by 심소영 on 6/24/24.
//

import UIKit
import Alamofire

extension UIViewController {
    func showAlert(title: String, message: String, button: String , completionHandler: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let open = UIAlertAction(title: button, style: .default) { _ in
            completionHandler()
        }
        let delete = UIAlertAction(title: "취소", style: .destructive)
        alert.addAction(open)
        alert.addAction(delete)
        self.present(alert, animated: true)
    }
}

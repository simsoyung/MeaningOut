//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/17/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchViewController: UIViewController {
    
    let numResultLabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = TextResource.ColorRGB.orangeUI
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let items = UserDefaults.standard.array(forKey: "word") as? [String] {
            if let textWord = items.last {
                navigationItem.title = "\(textWord)"
                configureHierarchy()
                configureLayout()
                configureUI()
            }
        }
    }

    func configureHierarchy(){}
    func configureLayout(){}
    func configureUI(){}

}

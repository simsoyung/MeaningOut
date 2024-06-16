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
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = TextResource.ColorRGB.orangeUI
        return label
    }()
    
    let simButton = SearchTypeButton(type: TextResource.TypeButton.simButton.rawValue)
    let dateButton = SearchTypeButton(type: TextResource.TypeButton.dateButton.rawValue)
    let ascButton = SearchTypeButton(type: TextResource.TypeButton.ascButton.rawValue)
    let dscButton = SearchTypeButton(type: TextResource.TypeButton.dscButton.rawValue)

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = UserDefaults.standard.array(forKey: "word") as? [String] {
            if let textWord = items.last {
                navigationItem.title = "\(textWord)"
                configureHierarchy()
                configureLayout()
                configureUI()
            }
        }
    }
    func configureHierarchy(){
        view.addSubview(numResultLabel)
        view.addSubview(simButton)
        view.addSubview(dateButton)
        view.addSubview(ascButton)
        view.addSubview(dscButton)

    }
    func configureLayout(){
        numResultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
        simButton.snp.makeConstraints { make in
            make.top.equalTo(numResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(numResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(simButton.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        ascButton.snp.makeConstraints { make in
            make.top.equalTo(numResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateButton.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        dscButton.snp.makeConstraints { make in
            make.top.equalTo(numResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(ascButton.snp.trailing).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }


    }
    func configureUI(){
        view.backgroundColor = .white
        numResultLabel.text = "25,994개"
    }


}

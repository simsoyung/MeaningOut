//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {

    var ud = UserDefaultManager()
    let mainImage = UIImageView()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let changeProfile = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextResource.NaviText.setting.rawValue
        configureHierarchy()
        configureLayout()
        configureUI()
        mainImage.settingImage()
    }
    
    func configureHierarchy(){
        view.addSubview(mainImage)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(changeProfile)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
    }
    func configureLayout(){
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.size.equalTo(100)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(mainImage.snp.trailing).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(150)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(mainImage.snp.trailing).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(150)
        }
        changeProfile.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.size.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI(){
        view.backgroundColor = .white
        nameLabel.backgroundColor = .red
        dateLabel.backgroundColor = .blue
        changeProfile.backgroundColor = .red
    }

}
    
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettiingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
        return cell
    }
    
    
}

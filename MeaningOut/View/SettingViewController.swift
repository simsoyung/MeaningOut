//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    let settingList = ["나의 장바구니 목록","자주 묻는 질문","1:1 문의","알림 설정","탈퇴하기"]
    
    var ud = UserDefaultManager()
    let mainImage = UIImageView()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let changeProfile = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = TextResource.NaviText.setting.rawValue
        configureHierarchy()
        configureLayout()
        configureUI()
        mainImage.settingImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let backImage = UserDefaults.standard.string(forKey: "imageNum") {
            mainImage.image = UIImage(named: "\(backImage)")
        }
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
        tableView.rowHeight = 60
        changeProfile.addTarget(self, action: #selector(changeProfileTapped), for: .touchUpInside)
        
    }
    
    @objc func changeProfileTapped(){
        navigationController?.pushViewController(ImageSettingViewController(), animated: true)
    }
    func configureLayout(){
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.size.equalTo(100)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(30)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI(){
        view.backgroundColor = .white
        nameLabel.settingName()
        dateLabel.settingDate()
        nameLabel.text = UserDefaults.standard.string(forKey: "nickname")
        dateLabel.text = UserDefaults.standard.string(forKey: "date")
        changeProfile.setImage(UIImage(systemName: TextResource.SystemImageName.setChervron.rawValue), for: .normal)
        changeProfile.tintColor = TextResource.ColorRGB.blackUI
    }
}
    
    extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return settingList.count
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 4 {
                let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. \n 탈퇴하시겠습니까?", preferredStyle: .alert)
                let open = UIAlertAction(title: "확인", style: .default) { _ in
                    UserDefaults.standard.set(false, forKey: "isUser")
                    UserDefaults.standard.removeObject(forKey: "word")
                    MainViewController.wordList.removeAll()
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let rootViewController = UINavigationController(rootViewController: ViewController())
                    sceneDelegate?.window?.rootViewController = rootViewController
                    sceneDelegate?.window?.makeKeyAndVisible()
                }
                let delete = UIAlertAction(title: "취소", style: .destructive)
                alert.addAction(open)
                alert.addAction(delete)
                self.present(alert, animated: true)
            }
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
            cell.label.text = settingList[indexPath.row]
            cell.selectionStyle = .none
            if indexPath.row != 0 {
                cell.likeLabel.textColor = .clear
                cell.shopImage.isHidden = true
            }
            return cell
        }
}

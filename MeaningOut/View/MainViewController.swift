//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift


class MainViewController: UIViewController {
    
    var wordList: [String] = []
    let ud = UserDefaultManager()
    let search = UISearchController()
    let deleteButton = UIButton()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let nickname = UserDefaults.standard.string(forKey: "nickname"){
            navigationItem.title = "\(nickname)\(TextResource.NaviText.userIDtext.rawValue)"
        }
        navigationItem.searchController = search
        search.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        configureHierarchy()
        configureLayout()
        configureUI()
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        if let items = UserDefaults.standard.array(forKey: "word") as? [String] {
            wordList = items
            tableView.reloadData()
        }
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.id)
    }
    
    func configureLayout(){
            deleteButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
                make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.height.equalTo(25)
                make.width.equalTo(60)
            }
            tableView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
    }

    func configureHierarchy(){
        view.addSubview(tableView)
        view.addSubview(deleteButton)
        tableView.delegate = self
        tableView.dataSource = self
        search.searchBar.delegate = self
    }

    func configureUI(){
        view.backgroundColor = .white
        search.searchBar.placeholder = TextResource.TextFieldPlaceholder.search.rawValue
        deleteButton.deleteBt()
    }
    
    @objc func deleteButtonTapped(){
        if deleteButton.isEnabled {
            wordList.removeAll()
            UserDefaults.standard.removeObject(forKey: "word")
            tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if wordList.isEmpty {
            return 500
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TextResource.LabelText.recentWord.rawValue
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = TextResource.ColorRGB.blackUI
        header.textLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if wordList.count == 0 {
            return 1
        } else {
            return wordList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if wordList.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.id, for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else {
                return UITableViewCell()
            }
            let data = wordList[indexPath.row]
            cell.configureCell(list: data)
            return cell
        }
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if let text = searchBar.text {
            wordList.append("\(text)")
            UserDefaults.standard.set(self.wordList, forKey: "word")
            tableView.reloadData()
        }
        return true
    }
}

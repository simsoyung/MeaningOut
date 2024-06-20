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
    
    static var wordList: [String] = []
    let ud = UserDefaultManager()
    let search = UISearchController()
    let deleteButton = UIButton()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        if let nickname = UserDefaults.standard.string(forKey: "nickname"){
            navigationItem.title = "\(nickname)\(TextResource.NaviText.userIDtext.rawValue)"
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.searchController = search
        search.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        configureHierarchy()
        configureLayout()
        configureUI()
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        if let items = UserDefaults.standard.stringArray(forKey: "word"){
            MainViewController.wordList = items
            tableView.reloadData()
        }
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.id)
        search.searchBar.autocorrectionType = .no
        search.searchBar.spellCheckingType = .no
    }
    
    func configureLayout(){
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(25)
            make.width.equalTo(60)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
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
            MainViewController.wordList.removeAll()
            UserDefaults.standard.removeObject(forKey: "word")
            tableView.reloadData()
        }
    }
    
    @objc func cancelBtTapped(sender: UIButton){
        MainViewController.wordList.remove(at: sender.tag)
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? EmptyTableViewCell {
            return cell.isSelected = false
        }
        let row = MainViewController.wordList[indexPath.row]
        MainViewController.wordList.append("\(row)")
        UserDefaults.standard.set(MainViewController.wordList, forKey: "word")
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if MainViewController.wordList.isEmpty {
            return 500
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if MainViewController.wordList.count == 0 {
            return 1
        } else {
            return MainViewController.wordList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if MainViewController.wordList.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.id, for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else {
                return UITableViewCell()
            }
            let data = MainViewController.wordList[indexPath.row]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.configureCell(list: data)
            cell.cancelButton.tag = indexPath.row
            cell.cancelButton.addTarget(self, action: #selector(cancelBtTapped(sender:)), for: .touchUpInside)
            return cell
        }
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if let text = searchBar.text {
            if text.isEmpty {
                return false
            } else {
                if MainViewController.wordList.contains(text){
                    print("중복된 글자")
                } else {
                    UserDefaults.standard.set(MainViewController.wordList, forKey: "word")
                    MainViewController.wordList.append(text)
                }
                tableView.reloadData()
                searchBar.text = ""
                let searchVC = SearchViewController()
                navigationController?.pushViewController(searchVC, animated: true)
            }
        }
        return true
    }
}

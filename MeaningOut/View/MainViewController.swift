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
    let header = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let items = UserDefaults.standard.array(forKey: "word") as? [String] {
            wordList = items
            tableView.reloadData()
        }
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.id)
        search.searchBar.autocorrectionType = .no
        search.searchBar.spellCheckingType = .no
    }
    
    func configureLayout(){
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(30)
        }
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
        view.addSubview(header)
        tableView.delegate = self
        tableView.dataSource = self
        search.searchBar.delegate = self
    }

    func configureUI(){
        view.backgroundColor = .white
        search.searchBar.placeholder = TextResource.TextFieldPlaceholder.search.rawValue
        deleteButton.deleteBt()
        header.headerLabel()
    }
    
    @objc func deleteButtonTapped(){
        if deleteButton.isEnabled {
            wordList.removeAll()
            UserDefaults.standard.removeObject(forKey: "word")
            tableView.reloadData()
        }
    }
    
    @objc func cancelBtTapped(sender: UIButton){
        wordList.remove(at: sender.tag)
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = wordList[indexPath.row]
        wordList.append("\(row)")
        UserDefaults.standard.set(self.wordList, forKey: "word")
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if wordList.isEmpty {
            return 500
        } else {
            return 50
        }
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
                wordList.append("\(text)")
                UserDefaults.standard.set(self.wordList, forKey: "word")
                tableView.reloadData()
                searchBar.text = ""
                navigationController?.pushViewController(SearchViewController(), animated: true)
            }
        }
        return true
    }
}

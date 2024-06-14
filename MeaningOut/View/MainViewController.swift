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
    let tableView = UITableView()
    let emptyView = UIImageView()
    let emptyLable = UILabel()
    let deleteButton = UIButton()

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
    }
    
    func configureHierarchy(){
        view.addSubview(tableView)
        view.addSubview(deleteButton)
        view.addSubview(emptyView)
        view.addSubview(emptyLable)
        tableView.delegate = self
        tableView.dataSource = self
        search.searchBar.delegate = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    func configureLayout(){
        if UserDefaults.standard.stringArray(forKey: "word") != nil {
            deleteButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
                make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.height.equalTo(25)
                make.width.equalTo(60)
            }
            tableView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
        } else {
            emptyView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
            emptyLable.snp.makeConstraints { make in
                make.top.equalTo(emptyView.snp.bottom).inset(150)
                make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
                make.height.equalTo(44)
            }
        }
    }

    func configureUI(){
        view.backgroundColor = .white
        search.searchBar.placeholder = TextResource.TextFieldPlaceholder.search.rawValue
        emptyView.contentMode = .scaleAspectFit
        emptyView.image = UIImage(named: "empty")
        emptyLable.emptyLabel()
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TextResource.LabelText.recentWord.rawValue
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = TextResource.ColorRGB.blackUI
        header.textLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        let data = wordList[indexPath.row]
        cell.configureCell(list: data)
        return cell
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

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
    
    let search = UISearchController()
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
    }
    
    func configureHierarchy(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
    }
    func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI(){
        view.backgroundColor = .white
        search.searchBar.placeholder = TextResource.TextFieldPlaceholder.search.rawValue
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        return cell
    }
    
    
}

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
    
    lazy var searchTypeView = UICollectionView(frame: .zero, collectionViewLayout: typeViewLayout())

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
        view.addSubview(searchTypeView)
        searchTypeView.delegate = self
        searchTypeView.dataSource = self
        searchTypeView.register(SearchTypeButtonCollectionViewCell.self, forCellWithReuseIdentifier: SearchTypeButtonCollectionViewCell.id)
    }
    func configureLayout(){
        numResultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
        searchTypeView.snp.makeConstraints { make in
            make.top.equalTo(numResultLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(35)
        }

    }
    func configureUI(){
        view.backgroundColor = .white
        numResultLabel.text = "25,994개"
        
    }
    
    func typeViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left:cellSpacing, bottom: 0, right: cellSpacing)
        return layout
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TextResource.TypeButton.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchTypeButtonCollectionViewCell.id, for: indexPath) as! SearchTypeButtonCollectionViewCell
        if cell.clickCount == 1 {
            cell.clickCount = 0
        } else {
            cell.clickCount += 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchTypeButtonCollectionViewCell.id, for: indexPath) as! SearchTypeButtonCollectionViewCell
        let data = TextResource.TypeButton.allCases[indexPath.item]
        
        return cell
    }
    
    
}

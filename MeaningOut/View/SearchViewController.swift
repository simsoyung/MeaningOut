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
    
    var shoppingList = KakaoSearch(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    
    var lastWord = ""
    let productId: [String] = []
    var startPage = 1
    var totalCount = 30
    
    var numResultLabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = TextResource.ColorRGB.orangeUI
        return label
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
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
                requestSearch(typeText: "sim")
                simButton.addTarget(self, action: #selector(simButtonClicked), for: .touchUpInside)
                dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
                ascButton.addTarget(self, action: #selector(ascButtonClicked), for: .touchUpInside)
                dscButton.addTarget(self, action: #selector(dscButtonClicked), for: .touchUpInside)
            }
        }
        
    }
    func configureHierarchy(){
        view.addSubview(numResultLabel)
        view.addSubview(simButton)
        view.addSubview(dateButton)
        view.addSubview(ascButton)
        view.addSubview(dscButton)
        view.addSubview(collectionView)
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(KakaoCollectionViewCell.self, forCellWithReuseIdentifier: KakaoCollectionViewCell.id)

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
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(simButton.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }


    }
    func configureUI(){
        view.backgroundColor = .white
    }
    
    @objc func simButtonClicked(){
            requestSearch(typeText: "sim")
    }
    
    @objc func dateButtonClicked(){
            requestSearch(typeText: "date")
    }
    
    @objc func ascButtonClicked(){
        requestSearch(typeText: "asc")
    }
    
    @objc func dscButtonClicked(){
        requestSearch(typeText: "dsc")
    }
    func requestSearch(typeText: String){
        let url = "\(API.APIURL.kakaoShoppingURL)"
        if let items = UserDefaults.standard.array(forKey: "word") as? [String] {
            let word = "\(items.last ?? "")"
            lastWord = word
        }
        let parameter: Parameters = ["query": "\(lastWord)", "display": "\(totalCount)", "start": "\(startPage)", "sort": typeText]
        let header: HTTPHeaders = ["X-Naver-Client-Id" : API.APIKey.id, "X-Naver-Client-Secret": API.APIKey.key]
        AF.request(url, parameters: parameter, headers: header).responseDecodable(of: KakaoSearch.self) { response in
                switch response.result {
                case .success(let value):
                    self.shoppingList = value
                    self.numResultLabel.text = "\(self.shoppingList.total.formatted())개의 검색 결과"
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
                    }
    }
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 1)
        layout.itemSize = CGSize(width: width/2, height: width/2 * 1.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = sectionSpacing
        layout.sectionInset = UIEdgeInsets(top: cellSpacing, left: sectionSpacing, bottom: cellSpacing, right: sectionSpacing)
        return layout
    }

}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KakaoCollectionViewCell.id, for: indexPath) as! KakaoCollectionViewCell
        guard let data = shoppingList.items?[indexPath.item] else { return cell }
        cell.configurecell(data: data)
        cell.wordView.layer.cornerRadius = 10
        cell.wordView.clipsToBounds = true
        return cell
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
}

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
    
    var shoppingList = KakaoSearch(lastBuildDate: "", total: 0, start: 1, display: 30, items: [])
    
    var lastWord = ""
    var productId: [String] = []
    var ud = UserDefaultManager()
    
    var numResultLabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = TextResource.ColorRGB.orangeUI
        return label
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var btArray = [UIButton]()
    let simButton = SearchTypeButton(type: TextResource.TypeButton.simButton.rawValue, selected: true)
    let dateButton = SearchTypeButton(type: TextResource.TypeButton.dateButton.rawValue, selected: false)
    let ascButton = SearchTypeButton(type: TextResource.TypeButton.ascButton.rawValue, selected: false)
    let dscButton = SearchTypeButton(type: TextResource.TypeButton.dscButton.rawValue, selected: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
        if let items = UserDefaults.standard.stringArray(forKey: "word") {
            if let textWord = items.last {
                navigationItem.title = "\(textWord)"
                configureHierarchy()
                configureLayout()
                configureUI()
                //UserDefaults.standard.set("sim", forKey: "type")
                requestSearch(typeText: "sim")
                btArray.append(simButton)
                btArray.append(dateButton)
                btArray.append(ascButton)
                btArray.append(dscButton)
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
    
    func selectOptionBtnAction(_ sender: UIButton) {
            for Btn in btArray {
                if Btn == sender {
                    Btn.isSelected = true
                    if Btn.isSelected == true {
                        UserDefaults.standard.set(self.productId, forKey: "id")
                    }
                    Btn.setTitleColor(TextResource.ColorRGB.whiteUI, for: .selected)
                    Btn.backgroundColor = TextResource.ColorRGB.darkGrayUI
                    
                } else {
                    Btn.isSelected = false
                    Btn.setTitleColor(TextResource.ColorRGB.darkGrayUI, for: .normal)
                    Btn.backgroundColor = TextResource.ColorRGB.whiteUI
                }
            }
        }
    
    @objc func simButtonClicked(){
        shoppingList.start = 1
        shoppingList.items?.removeAll()
        ud.type = "sim"
        requestSearch(typeText: "sim")
        
        selectOptionBtnAction(simButton)
    }
    
    @objc func dateButtonClicked(){
        shoppingList.start = 1
        shoppingList.items?.removeAll()
        ud.type = "date"
        requestSearch(typeText: "date")
        selectOptionBtnAction(dateButton)
    }
    
    @objc func ascButtonClicked(){
        shoppingList.start = 1
        shoppingList.items?.removeAll()
        ud.type = "asc"
        requestSearch(typeText: "asc")
        selectOptionBtnAction(ascButton)
    }
    
    @objc func dscButtonClicked(){
        shoppingList.start = 1
        shoppingList.items?.removeAll()
        ud.type = "dsc"
        requestSearch(typeText: "dsc")
        selectOptionBtnAction(dscButton)
    }
    func requestSearch(typeText: String){
        let url = "\(API.APIURL.kakaoShoppingURL)"
        if let items = UserDefaults.standard.stringArray(forKey: "word") {
            let word = "\(items.last ?? "")"
            lastWord = word
        }
        let parameter: Parameters = ["query": "\(lastWord)", "display": "\(shoppingList.display)", "start": "\(shoppingList.start)", "sort": typeText]
        let header: HTTPHeaders = ["X-Naver-Client-Id" : API.APIKey.id, "X-Naver-Client-Secret": API.APIKey.key]
        AF.request(url, parameters: parameter, headers: header).responseDecodable(of: KakaoSearch.self) { response in
            switch response.result {
                case .success(let value):
                if self.shoppingList.start == 1 {
                    self.shoppingList = value
                    self.numResultLabel.text = "\(self.shoppingList.total.formatted())개의 검색 결과"
                } else {
                    self.shoppingList.items?.append(contentsOf: value.items!)
                }
                guard self.collectionView.numberOfSections > 0 else { return }
                print("스크롤 top: \(self.collectionView.numberOfSections)")
                self.collectionView.setContentOffset(.zero, animated: true)
                self.collectionView.reloadData()
                UserDefaults.standard.set(typeText, forKey: "type")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = shoppingList.items?[indexPath.item] else { return }
        ud.productName = "\(data.title)"
        ud.url = "\(data.link)"
        navigationController?.pushViewController(WebViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KakaoCollectionViewCell.id, for: indexPath) as! KakaoCollectionViewCell
        guard let data = shoppingList.items?[indexPath.item] else { return cell }
        cell.configurecell(data: data)
        cell.wordView.layer.cornerRadius = 10
        cell.wordView.clipsToBounds = true
        if cell.shoppingBagButton.isSelected == true {
            let id = shoppingList.items?[indexPath.item].productID
            UserDefaults.standard.set(id, forKey: "id")
            self.productId.append(id ?? "")
            
        }
        return cell
        }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
        
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if shoppingList.items!.count - 2 == item.row && shoppingList.total > shoppingList.start{
                shoppingList.start += shoppingList.display
                let type = UserDefaults.standard.string(forKey: "type")
                requestSearch(typeText: "\(type ?? "sim")")
            }
        }
    }
}

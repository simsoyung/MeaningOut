//
//  KakaoCollectionViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/17/24.
//

import UIKit
import SnapKit
import Kingfisher
class KakaoCollectionViewCell: UICollectionViewCell {
    static let id = "KakaoCollectionViewCell"
    
    var shoppingList = KakaoSearch(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    var ud = UserDefaultManager()
    let wordView = UIImageView()
    let nameLabel = UILabel()
    let storeLabel = UILabel()
    let priceLabel = UILabel()
    var shoppingBagButton = UIButton()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
        shoppingBagButton.shopBt(like: false)
        shoppingBagButton.addTarget(self, action: #selector(likeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeButton(){
        likeClicked(shoppingBagButton)
    }

    
    func likeClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            shoppingBagButton.setImage(UIImage(named: "like_selected"), for: .normal)
            shoppingBagButton.backgroundColor = TextResource.ColorRGB.whiteUI
            ud.like = true
        } else {
            shoppingBagButton.setImage(UIImage(named: "like_unselected"), for: .normal)
            shoppingBagButton.backgroundColor = TextResource.ColorRGB.grayUI
            shoppingBagButton.alpha = 0.8
            ud.like = false
        }
    }
    func configurecell(data: Item) {
        let urlImage = "\(data.image)"
        let url = URL(string: urlImage)
        wordView.kf.setImage(with: url)
        let title = "\(data.title)"
        nameLabel.text = title.htmlEscaped
        if let mall = data.mallName {
            storeLabel.text = mall
        }
        if let price = data.lprice {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            guard let number = Int("\(price)") else { return }
            let result = numberFormatter.string(from: NSNumber(value: number))
            if result != nil {
                priceLabel.text = "\(result ?? "")원"
            }
        }
    }
        func configureHierarchy(){
            contentView.addSubview(wordView)
            contentView.addSubview(nameLabel)
            contentView.addSubview(storeLabel)
            contentView.addSubview(priceLabel)
            contentView.addSubview(shoppingBagButton)
        }
        func configureLayout(){
            wordView.snp.makeConstraints { make in
                make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
                make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
                make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(80)
            }
            storeLabel.snp.makeConstraints { make in
                make.top.equalTo(wordView.snp.bottom).offset(5)
                make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
                make.height.equalTo(20)
            }
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(storeLabel.snp.bottom).offset(5)
                make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
                make.height.equalTo(40)
            }
            priceLabel.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(5)
                make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
                make.height.equalTo(20)
            }
            shoppingBagButton.snp.makeConstraints { make in
                make.top.equalTo(wordView.snp.bottom).inset(35)
                make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
                make.size.equalTo(25)
            }
        }
        func configureUI(){
            storeLabel.mallLabel()
            nameLabel.storeSubLabel()
            priceLabel.priceLabel()
        }

}

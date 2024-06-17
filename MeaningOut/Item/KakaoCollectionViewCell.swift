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
    
    let wordView = UIImageView()
    let nameLabel = UILabel()
    let storeLabel = UILabel()
    let priceLabel = UILabel()
    let shoppingBagButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        shoppingBagButton.setImage(UIImage(named: "like_unselected"), for: .normal)
    }
}
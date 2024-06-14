//
//  ImageCollectionViewCell.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit
import SnapKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let id = "ImageCollectionViewCell"
    
    let imageList = ProfileImage.randomImage
    var imageView = ProfileImage(imageAlpha: 0.5, radius: 40, bordercolor: TextResource.ColorRGB.grayCG, width: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    override var isSelected: Bool {
        didSet{
            if isSelected {
                imageView.alpha = 1
                imageView.layer.borderColor = TextResource.ColorRGB.orangeCG
                imageView.layer.borderWidth = 3
            } else {
                imageView.alpha = 0.5
                imageView.layer.borderColor = TextResource.ColorRGB.grayCG
                imageView.layer.borderWidth = 1
            }
        }
    }
    
    func configureHierarchy(){
        contentView.addSubview(imageView)
    }
    func configureLayout(){
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    func configureUI(setImage: String){
        imageView.image = UIImage(named: "\(setImage)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


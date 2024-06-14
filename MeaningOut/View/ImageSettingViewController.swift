//
//  ImageSettingViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/14/24.
//

import UIKit
import SnapKit

class ImageSettingViewController: UIViewController {
    
    let ud = UserDefaultManager()
    let profileImage = ProfileImage(imageAlpha: 1, radius: 60, bordercolor: TextResource.ColorRGB.orangeCG, width: 3)
    let cameraButton = CameraButton(frame: .zero)
    lazy var imagecollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextResource.NaviText.profile.rawValue
        cameraButton.isEnabled = false 
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        view.addSubview(profileImage)
        view.addSubview(cameraButton)
        view.addSubview(imagecollectionView)
        imagecollectionView.delegate = self
        imagecollectionView.dataSource = self
        imagecollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.id)
        imagecollectionView.allowsMultipleSelection = false
    }
    func configureLayout(){
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(120)
            make.centerX.equalTo(self.view)
        }
        cameraButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).inset(30)
            make.size.equalTo(30)
            make.centerX.equalTo(self.view).offset(40)
        }
        imagecollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)

        }
    }
    func configureUI(){
        view.backgroundColor = .white
    }
    
    func collectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = sectionSpacing
        layout.sectionInset = UIEdgeInsets(top: cellSpacing, left: sectionSpacing, bottom: cellSpacing, right: sectionSpacing)
        return layout
    }
}

extension ImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileImage.randomImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as! ImageCollectionViewCell
        let data = ProfileImage.randomImage[indexPath.item]
        cell.configureUI(setImage: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ud.imageIndex = String(indexPath.row)
        if let num = UserDefaults.standard.string(forKey: "imageNum"){
            profileImage.image = UIImage(named: "\(num)")
        }
    }
}



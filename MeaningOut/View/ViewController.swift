//
//  ViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/13/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let logoImage = UIImageView()
    let launchImage = UIImageView()
    let startButton = OrangeButton(title: .start)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

    }
    private func configureHierarchy(){
        view.addSubview(logoImage)
        view.addSubview(launchImage)
        view.addSubview(startButton)
    }
    private func configureLayout(){
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(21)
        }
        launchImage.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.height.equalTo(44)
        }
    }
    
    private func configureUI(){
        view.backgroundColor = .white
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode = .scaleAspectFill
        launchImage.image = UIImage(named: "launch")
        launchImage.contentMode = .scaleAspectFit
    }
    
    @objc func startButtonTapped(){
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}


//
//  WebViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/18/24.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    
    let webview = WKWebView()
    var ud = UserDefaultManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if ud.like {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_selected"), style: .plain, target: nil, action: #selector(WebViewController.clickedLikeOff))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "like_unselected"), style: .plain, target: nil, action:  #selector(WebViewController.clickedLikeOn))
        }
        if let items = UserDefaults.standard.string(forKey: "productName") {
            navigationItem.title = "\(items.htmlEscaped)"
        }
        if let webURL = UserDefaults.standard.string(forKey: "url") {
            guard let ud = URL(string: webURL) else { return }
            let request = URLRequest(url: ud)
            webview.load(request)
        }
        configureHierarchy()
        configureLayout()
        configureUI()
        
    }
    func configureHierarchy(){
        view.addSubview(webview)
    }
    func configureLayout(){
        webview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureUI(){
        view.backgroundColor = .white
    }
    
    @objc func clickedLikeOn(){
        ud.like = true
        navigationItem.rightBarButtonItem?.image = UIImage(named: "like_selected")
    }
    @objc func clickedLikeOff(){
        ud.like = false
        navigationItem.rightBarButtonItem?.image = UIImage(named: "like_unselected")
    }
    
}

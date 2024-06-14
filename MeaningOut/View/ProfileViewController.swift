//
//  ProfileViewController.swift
//  MeaningOut
//
//  Created by 심소영 on 6/13/24.
//

import UIKit
import IQKeyboardManagerSwift
import SnapKit

class ProfileViewController: UIViewController {

    let ud = UserDefaultManager()
    var profileImage = ProfileImage(imageAlpha: 1, radius: 60, bordercolor: TextResource.ColorRGB.orangeCG, width: 3)
    let selecteButton = OrangeButton(title: TextResource.ButtonText.finish)
    let cameraButton = CameraButton.init(frame: .zero)
    let textField = NicknameTextField(frame: .zero)
    let controlLabel = ControlLabel(titleText: TextResource.LabelText.nicknameDefalut)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = TextResource.NaviText.profile.rawValue
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: TextResource.SystemImageName.chevron.rawValue)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        configureHierarchy()
        configureLayout()
        configureUI()
        selecteButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let backImage = UserDefaults.standard.string(forKey: "imageNum") {
            profileImage.image = UIImage(named: "\(backImage)")
        }
    }

    private func configureHierarchy(){
        view.addSubview(profileImage)
        view.addSubview(selecteButton)
        view.addSubview(cameraButton)
        view.addSubview(textField)
        view.addSubview(controlLabel)
        textField.delegate = self
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        selecteButton.addTarget(self, action: #selector(selecteButtonTapped), for: .touchUpInside)
    }
    private func configureLayout(){
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
        textField.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        controlLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        selecteButton.snp.makeConstraints { make in
            make.top.equalTo(controlLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.height.equalTo(44)
        }
    }
    
    private func configureUI(){
        view.backgroundColor = .white
    }
    
    @objc func cameraButtonTapped(){
        navigationController?.pushViewController(ImageSettingViewController(), animated: true)
        
    }
    
    @objc func selecteButtonTapped(){
        navigationController?.pushViewController(MainViewController(), animated: true)
        ud.nickname = textField.text ?? ""
        UserDefaults.standard.set(true, forKey: "isUser")
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let rootViewController = UINavigationController(rootViewController: MainViewController())
        
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }

}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width, color: TextResource.ColorRGB.darkGrayUI)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: view.bounds.width, color: TextResource.ColorRGB.grayUI)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let minLength = 2
        let maxLength = 10
        let char: CharacterSet = CharacterSet(charactersIn: "@#$%")
        let num: CharacterSet = CharacterSet(charactersIn: "0123456789")
        guard let text = textField.text else { return false }
        if text.count >= maxLength {
            controlLabel.text = TextResource.LabelText.nicknameCountLabelFalse.rawValue
            selecteButton.isEnabled = false
        } else if text.count < minLength {
            controlLabel.text = TextResource.LabelText.nicknameCountLabelFalse.rawValue
            selecteButton.isEnabled = false
        } else {
            controlLabel.text = TextResource.LabelText.nicknameCountLabelTrue.rawValue
            selecteButton.isEnabled = true
        }
        if (text.rangeOfCharacter(from: char) != nil) {
            controlLabel.text = TextResource.LabelText.nicknameCharFalse.rawValue
            selecteButton.isEnabled = false
        }
        if (text.rangeOfCharacter(from: num) != nil){
            controlLabel.text = TextResource.LabelText.nicknameNumFalse.rawValue
            selecteButton.isEnabled = false
        }
        return true
    }

} // end

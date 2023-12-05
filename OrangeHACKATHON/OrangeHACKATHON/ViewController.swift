//
//  ViewController.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 13.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        StorageUserDefaultModal.checkLogin = false
        setUI()
    }
   
    private func setUI(){
        
        let selfView = UIView()
        view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        selfView.backgroundColor = UIColor(red: 1, green: 0.87, blue: 0.082, alpha: 1)
        selfView.addSubview(signUpBTN)
        selfView.addSubview(signInBTN)
        
        signInBTN.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
        signUpBTN.addTarget(self, action: #selector(openSignUp), for: .touchUpInside)
        
        signInBTN.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(signInBTN.snp.bottom).offset(-54)
        }
        signUpBTN.snp.makeConstraints { make in
            make.bottom.equalTo(signInBTN.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(signUpBTN.snp.bottom).offset(-54)
        }
       
        
        selfView.addSubview(logo)
        
        logo.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
            
        }
        
        selfView.addSubview(logo1)
        
        logo1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        selfView.addSubview(logo2)
        
        logo2.snp.makeConstraints { make in
            make.bottom.equalTo(logo.snp.top)
            make.leading.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        selfView.addSubview(logo3)
        
        logo3.snp.makeConstraints { make in
            make.bottom.equalTo(signUpBTN.snp.top)
            make.trailing.equalToSuperview()
            make.width.height.equalTo(150)
        }
    }
    
    @objc func openSignIn(){
        navigationController?.pushViewController(SignIn(), animated: true)
    }
    
    @objc func openSignUp(){
        navigationController?.pushViewController(SignUp(), animated: true)
    }
    
    private let logo3: UIImageView = {
        let img = UIImageView(image: UIImage(named: "logo4"))
        return img
    }()
    
    private let logo2: UIImageView = {
        let img = UIImageView(image: UIImage(named: "logo3"))
        return img
    }()
    
    private let logo1: UIImageView = {
        let img = UIImageView(image: UIImage(named: "logo2"))
        return img
    }()
    
    private var logo: UIView = {
        let view = UIView()
        let img = UIImageView(image: UIImage(named: "logo1"))
        view.addSubview(img)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var signInBTN: UIButton = {
        let b: UIButton = btn(text: "I already have an account", color: .black)
        return b
    }()
    
    private lazy var signUpBTN: UIButton = {
        let b:UIButton = btn(text: "Sign Up", color: UIColor.white)
        return b
    }()
    
    private func btn(text: String, color: UIColor) -> UIButton {
        let btn: UIButton = UIButton()
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 22)
        btn.setTitleColor(color, for: .normal)
        btn.layer.cornerRadius = 16
        if(color == UIColor.black){
//            btn.backgroundColor = .orange
        }else{
            btn.backgroundColor = UIColor(red: 0, green: 0.650, blue: 0.306, alpha: 1)
        }
        
        return btn
    }
}


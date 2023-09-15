//
//  SignUp.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 13.09.2023.
//

import UIKit
import SnapKit

class SignUp: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        view.backgroundColor = UIColor(named: "green")
        navigationItem.title = "New User"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(password)
        
        password.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        view.addSubview(email)
        email.snp.makeConstraints { make in
            make.bottom.equalTo(password.snp.top).offset(-16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        view.addSubview(confirmPassword)
        confirmPassword.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        view.addSubview(logo)
        
        logo.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.bottom.equalTo(email.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(logIn)
        logIn.addTarget(self, action: #selector(pushSignUp), for: .touchUpInside)
        logIn.snp.makeConstraints { make in
            make.top.equalTo(confirmPassword.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(textHaveAccount)
        textHaveAccount.snp.makeConstraints { make in
            make.trailing.equalTo(logIn.snp.leading).offset(-10)
            make.top.equalTo(confirmPassword.snp.bottom).offset(16)
        }
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.top.equalTo(textHaveAccount.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }
    
    @objc func pushSignUp(){
        navigationController?.pushViewController(SignIn(), animated: true)
    }
    
    private let btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .orange.withAlphaComponent(0.9)
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    private let textHaveAccount: UILabel = {
     
        let text = UILabel()
        text.text = "Have an account?"
        text.textColor = .black
        text.font = .systemFont(ofSize: 14)
       
        return text
    }()
    
    private let logIn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(UIColor(named: "yellow"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    private let logo: UIImageView = {
        let img = UIImageView(image: UIImage(named: "logo4"))
        return img
    }()
    
    private lazy var email: UITextField = {
        let tx = textField(text: "Email")
        return tx
    }()
    
    private lazy var password: UITextField = {
        let tx = textField(text: "Password")
        tx.isSecureTextEntry = true
        return tx
    }()
    
    private lazy var confirmPassword: UITextField = {
        let tx = textField(text: "Confirm Password")
        tx.isSecureTextEntry = true
        return tx
    }()
    
    private func textField(text: String) -> UITextField{
        let tx = TextField()
        tx.placeholder = text
        tx.backgroundColor = .white
        return tx
    }
}

func textField(text: String) -> UITextField{
    let tx = TextField()
    tx.placeholder = text
    tx.backgroundColor = .white
    return tx
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

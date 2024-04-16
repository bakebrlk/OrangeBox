//
//  SignIn.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 13.09.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import SwiftUI

class SignIn: UIViewController, btnDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func openSignUp() {
        logUp.sendActions(for: .touchUpInside)
    }
    
    private func setUI(){
        view.backgroundColor = UIColor(named: "green")
        navigationItem.title = "Welcome to Back!"
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(email)
        email.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        view.addSubview(password)
        password.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.bottom.equalTo(email.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        view.addSubview(logUp)
        logUp.addTarget(self, action: #selector(pushSingUp), for: .touchUpInside)
        logUp.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(textHaveAccount)
        textHaveAccount.snp.makeConstraints { make in
            make.trailing.equalTo(logUp.snp.leading).offset(-10)
            make.top.equalTo(password.snp.bottom).offset(16)
        }
        
        view.addSubview(btnSignIn)
        btnSignIn.snp.makeConstraints { make in
            make.top.equalTo(textHaveAccount.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        btnSignIn.addTarget(self, action: #selector(checkSignIn), for: .touchUpInside)
        print("hi")
        
    }
    
    @objc func checkSignIn(){
        startLoading()
        guard let email = email.text, !email.isEmpty,
              let password = password.text, !password.isEmpty else{
                stopLoading()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password,completion:{ result, error in
            
            guard error == nil else{
                self.stopLoading()
                self.presentError()
                return
            }
            
            self.stopLoading()
//            let hosting = UIHostingController(rootView: MainView())
//            self.navigationController?.pushViewController( hosting, animated: true)
        })
    }
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var loadAuth:UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.view.addSubview(indicator)
        alert.view.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        return alert
    }()
    
    func startLoading(){
        present(loadAuth, animated: true)
        indicator.startAnimating()
    }
    
    func stopLoading(){
        loadAuth.dismiss(animated: true)
        indicator.stopAnimating()
    }



    
    private func presentError(){
        let error = ErrorForReg()
        
        error.delegate = self
        error.modalPresentationStyle = .pageSheet
        error.sheetPresentationController?.detents = [.medium()]
        error.sheetPresentationController?.prefersGrabberVisible = true
        
        present(error, animated: true)
    }
    
    @objc func pushSingUp(){
        navigationController?.pushViewController(SignUp(), animated: true)
    }
    
    private let btnSignIn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = .orange.withAlphaComponent(0.9)
        return btn
    }()
    
    private let textHaveAccount: UILabel = {
     
        let text = UILabel()
        text.text = "Don't have an account?"
        text.textColor = .black
        text.font = .systemFont(ofSize: 14)
       
        return text
    }()
    
    private let logUp: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor(named: "yellow"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    private let logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo3"))
        return logo
    }()
    
    private lazy var email: UITextField = {
        let tx = textField(text: "Email")
        tx.layer.cornerRadius = 16
        return tx
    }()
    
    private lazy var password: UITextField = {
        let tx = textField(text: "Password")
        tx.isSecureTextEntry = true
        tx.layer.cornerRadius = 16
        return tx
    }()
    
    private func textField(text: String) -> UITextField{
        let tx = UTextField()
        tx.placeholder = text
        tx.backgroundColor = .white
        return tx
    }
}

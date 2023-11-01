//
//  SignUp.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 13.09.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class SignUp: UIViewController {
    
    private var ntf = UIView()
    
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
        logIn.addTarget(self, action: #selector(pushSignIn), for: .touchUpInside)
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
        
        btn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
    }
    
    @objc func signUp(){
        startLoading()
        
        guard let email = email.text, !email.isEmpty,
              let password = password.text, !password.isEmpty,
              let confPassword = confirmPassword.text, !confPassword.isEmpty,
              password == confPassword
        else{
            guard let email = email.text, !email.isEmpty,
                  let password = password.text, !password.isEmpty,
                  let confPassword = confirmPassword.text, !confPassword.isEmpty,
                  password != confPassword
            else{
                stopLoading()
                return
            }
            
            stopLoading()
            errorDoesntMatchesPassword()
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [self]result, error in
            guard error == nil else{
                stopLoading()

                if(!email.contains("@") && (!email.contains(".ru") || !email.contains(".com"))){
                    self.errorEmailDoesntComplyPrinciples()
                }else if(!isPasswordValid(password)){
                    self.errorPasswordDoesntComplyPrinciples()
                }
                
                return
            }
            
            stopLoading()

            
        })
    }
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        return indicator
    }()
    
    private lazy var loadAuth:UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.view.addSubview(indicator)
        alert.view.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        return alert
    }()
    
    private func startLoading(){
        present(loadAuth, animated: true)
        indicator.startAnimating()
    }
    
    private func stopLoading(){
        loadAuth.dismiss(animated: true)
        indicator.stopAnimating()
    }

    
    private func isPasswordValid(_ password: String) -> Bool {
        var containsCapitalLetter = false
        var containsSmallLetter = false
        var containsNumber = false
        
        for character in password {
            if character.isUppercase {
                containsCapitalLetter = true
            } else if character.isLowercase {
                containsSmallLetter = true
            } else if character.isNumber {
                containsNumber = true
            }
            
        }

        return containsCapitalLetter && containsSmallLetter && containsNumber
    }
    
    
    private func errorEmailDoesntComplyPrinciples(){
        ntf = pushNotification("The email must contains \"@, .ru, .com\"")
    }

    private func errorDoesntMatchesPassword(){
        ntf = pushNotification("doesn't matches password")
    }
    
    private func errorPasswordDoesntComplyPrinciples(){
        ntf = pushNotification("The password must contain \"capital letters, small letters, numbers\"")
    }
    
    private func pushNotification(_ text: String) -> UIView{
        ntf = UIView()
        
        ntf.layer.cornerRadius = 16
        ntf.backgroundColor = .lightText

        view.addSubview(ntf)
                
        ntf.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-150)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .red
        
        ntf.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        ntf.snp.makeConstraints { make in
            make.width.equalTo(label.snp.width).offset(40)
            make.height.equalTo(label.snp.height).offset(20)
        }
        
        UIView.animate(withDuration: 2, animations: {
            self.ntf.alpha = 1.0
            self.ntf.center.y = CGFloat(-150)
        }){(_) in
            UIView.animate(withDuration: 5, animations: {
                self.ntf.alpha = 0.0
            }) { (_) in
                self.ntf.isHidden = true
            }
        }
        
        return ntf
    }
    
    @objc func pushSignIn(){
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
        tx.layer.cornerRadius = 16
        return tx
    }()
    
    private lazy var password: UITextField = {
        let tx = textField(text: "Password")
        tx.isSecureTextEntry = true
        tx.layer.cornerRadius = 16
        return tx
    }()
    
    private lazy var confirmPassword: UITextField = {
        let tx = textField(text: "Confirm Password")
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

func textField(text: String) -> UITextField{
    let tx = UTextField()
    tx.placeholder = text
    tx.backgroundColor = .white
    return tx
}

class UTextField: UITextField {

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

//
//  ErrorForReg.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 20.09.2023.
//

import UIKit
import SnapKit

protocol btnDelegate{
    func openSignUp()
}

class ErrorForReg: UIViewController{
    
    var delegate: btnDelegate?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        view.backgroundColor = .orange
        
        
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        
        view.addSubview(text)
        text.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(openSignUp), for: .touchUpInside)
        btn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        
    }
   
    
    @objc func openSignUp(){
        dismiss(animated: true){
            self.delegate?.openSignUp()
        }
    }
    
    private let btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Let's go sign up", for: .normal)
        btn.backgroundColor = UIColor(named: "green")
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    private let logo: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo2"))
        return image
    }()
    
    private let text: UILabel = {
        let text = UILabel()
        text.text = "Oowww sorry, maybe you don't have account!"
        text.numberOfLines = 0
        text.font = .systemFont(ofSize: 24, weight: .bold)
        text.textAlignment = .center
        
        return text
    }()
}

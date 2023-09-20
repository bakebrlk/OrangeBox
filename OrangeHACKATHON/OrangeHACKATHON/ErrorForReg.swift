//
//  ErrorForReg.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 20.09.2023.
//

import UIKit
import SnapKit

class ErrorForReg: UIViewController, UISheetPresentationControllerDelegate{
    
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium()]
        
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
        btn.addTarget(self, action: #selector(pushSignUp), for: .touchUpInside)
        btn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
        
    }
    
    @objc func pushSignUp(){
       
        dismiss(animated: true)
    }
    
    private func openSignUp(){
        navigationController?.pushViewController(SignUp(), animated: true)
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

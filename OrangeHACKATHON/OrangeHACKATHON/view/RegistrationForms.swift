//
//  RegistrationForms.swift
//  Culinary Oasis
//
//  Created by bakebrlk on 02.12.2023.
//

import UIKit
import Lottie
import SnapKit

enum ConfirmRegistry{
    case phone
    case email
}

class RegistrationForms: UIViewController {
    
    var information: String
    var variant: ConfirmRegistry
    var name: String
    
    init(variant: ConfirmRegistry, information: String, name: String) {
        self.information = information
        self.variant = variant
        self.name = name
        super.init(nibName: nil, bundle: nil)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var titleView = getLabel(text: "Hi, \(name)", font: .boldSystemFont(ofSize: 30))
    
    private lazy var additionalTitleView = getLabel(text: "Welcome to Culinary Oasis", font: .systemFont(ofSize: 24, weight: .medium) )
    
    private lazy var descriptionView = getLabel(text: "We have sent you a confirmation message and a code by email: \(information). Please confirm your email.", font: .systemFont(ofSize: 18, weight: .thin))
    
    private func getLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }
    
    private var animation: LottieAnimationView = {
        
        let animationView = LottieAnimationView(name: "confirmRegistration")
        animationView.play()
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    
}
extension RegistrationForms{
    
    private func setUI(){
        view.backgroundColor = .white
        setViews()
        setControllers()
    }
    
    private func setViews(){
        view.addSubview(titleView)
        view.addSubview(additionalTitleView)
        view.addSubview(descriptionView)
        view.addSubview(animation)
    }
    
    private func setControllers(){
        animation.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(animation.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)  
        }
        
        additionalTitleView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(additionalTitleView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

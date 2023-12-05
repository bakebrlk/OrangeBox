//
//  RegistrationForms.swift
//  Culinary Oasis
//
//  Created by bakebrlk on 02.12.2023.
//

import UIKit

class RegistrationForms: UIViewController {
    
    var titleView: String
    var descriptionView: String
    
    init(title: String, description: String) {
        self.titleView = title
        self.descriptionView = description
        super.init(nibName: nil, bundle: nil)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var MainTextField: UITextField = {
        let tx = Culinary_Oasis.textField(text: descriptionView)
        tx.layer.cornerRadius = 16
        return tx
    }()
    
    private lazy var confirmTextField: UITextField = {
        let tx = Culinary_Oasis.textField(text: descriptionView)
        tx.layer.cornerRadius = 16
        return tx
    }()
    
    
}
extension RegistrationForms{
    
    private func setUI(){
        setViews()
        setControllers()
    }
    
    private func setViews(){
        
    }
    
    private func setControllers(){
        
    }
}

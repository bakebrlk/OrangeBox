//
//  MainView.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 15.09.2023.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        view.backgroundColor = .orange.withAlphaComponent(0.7)
    }
}

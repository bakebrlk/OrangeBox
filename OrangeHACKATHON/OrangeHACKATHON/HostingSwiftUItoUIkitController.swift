//
//  HostionSwiftUItoUIkitController.swift
//  Culinary Oasis
//
//  Created by bakebrlk on 04.12.2023.
//

import SwiftUI

struct HostionSwiftUItoUIkitController: UIViewControllerRepresentable {
    
    class UIKitViewController: UIViewController {
    
    }

    
    func makeUIViewController(context: Context) -> UIViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

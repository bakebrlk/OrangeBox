//
//  GroceriesApp.swift
//  Groceries
//
//  Created by Rauan on 19.10.2023.
//

import SwiftUI
import Stripe

@main
struct GroceriesApp: App {
    @StateObject var locationViewModel = LocationViewModel()
    var body: some Scene {
        WindowGroup {
           Main()
        }
    }
}

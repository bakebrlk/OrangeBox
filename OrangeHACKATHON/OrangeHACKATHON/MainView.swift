//
//  MainView.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 15.09.2023.
//
import SwiftUI

enum Tab {
    case market
    case card
    case ai
    case profile
}

struct MainView: View {
    
  //  @State private var tabItem: Tab = .market
    
    var body: some View {
        setUI()
    }
    
    private func setUI() -> some View{
        setTabItems()
    }
    
    private func setTabItems() -> some View {
        
        TabView {
            CardView()
                .tabItem {
                    cardTab
                }
            
            MarketView()
                .tabItem {
                    marketTab
                }
            
        }
        .background(Color.mint)
    }
    
    private var marketTab: some View {
        Text("Market")
    }
    
    private var cardTab: some View {
       Text("Card")
    }
}

#Preview {
    MainView()
}

//
//  MainView.swift
//  OrangeHACKATHON
//
//  Created by bakebrlk on 15.09.2023.
//
import SwiftUI

enum Tab {
    case market
    case cart
    case ai
    case profile
}

struct MainView: View {
    
    @State private var tabItem: Tab = .market
    
    var body: some View {
        setUI()
    }
    
    private func setUI() -> some View{
        
        VStack{
            if(tabItem == .market){
                MarketView()
                
            }else if(tabItem == .cart){
                CardView()
            }
            
            Spacer()
            setTabItems()
        }
    }
    
    
    private func setTabItems() -> some View {

        HStack{
            Spacer()
            
            getItem(text: "Market", image: Image(systemName: "house"), item: .market)
            
            Spacer()
            getItem(text: "Cart", image: Image(systemName: "cart"), item: .cart)
            
            Spacer()
        }
        .background(Color.green)
    }
    
    private func getItem(text: String, image: Image, item: Tab) -> some View{
        
        Button(action: {
            tabItem = item
        }, label: {
            VStack{
                image
                    .foregroundColor(tabItem == item ? Color.orange : Color.gray)
                
                Text(text)
                    .foregroundColor(tabItem == item ? Color.orange : Color.gray)
            }
            .padding(.top)
        })
 
        
    }
    
    private var marketTab: some View {
        Text("Market")
            .padding()
            .background(Color.red)
            .padding()
    }
    
    private var cartTab: some View {
       Text("Card")
    }
}

#Preview {
    MainView()
}

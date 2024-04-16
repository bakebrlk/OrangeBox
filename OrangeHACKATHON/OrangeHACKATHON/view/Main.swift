//
//  Main.swift
//  Groceries
//
//  Created by Rauan on 21.10.2023.
//
import Foundation
import SwiftUI
import CoreLocation

struct Main: View {
    @State private var selectedTab = 0
    @State private var showAllSpecialDeals = false
    @StateObject var HomeModel = UserLocation()
    
    @State private var cartItems: [CartItems] = []
    @State private var cartBadgeCount: Int = 0
    
    @State private var selectedCategory: String? = "Baker"
    @State private var cameFromCart: Bool = false
    @State private var likedItems: [Item] = []
    @State private var goToCategoryItemsView = false
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView(selectedCategory: $selectedCategory, cartItems: $cartItems, cameFromCart: $cameFromCart, likedItems: $likedItems)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            LikedItemView(likedItems: $likedItems,cartItems: $cartItems, selectedCategory: $selectedCategory, cameFromCart: $cameFromCart, goToCategoryItemsView: $goToCategoryItemsView)
                .tabItem {
                    Image(systemName: "heart")
                    Text("Liked Items")
                }
                .tag(1)
            
            //            SearchItemsView()
            //                .tabItem {
            //                    Image(systemName: "magnifyingglass")
            //                    Text("Search")
            //                }
            //                .tag(2)
            CartView(cartItems: $cartItems, selectedCategory: $selectedCategory, likedItems: $likedItems, cameFromCart: $cameFromCart)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        if cartBadgeCount > 0 {
                            Text("\(cartBadgeCount)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(4)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                
                        }
                    }
                    Text("Cart")
                }
                .tag(2)
                ChatView()
                .tabItem {
                    Image(systemName: "text.magnifyingglass")
                    Text("Helper")
                }
                .tag(3)
                    UserProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                        .tag(4)
                }
        }
    }
    
    

    struct MainView: View {
        @State private var itemsByCategory: [String: [Item]] = [
            "Fruit": [],
            "Vegetable": [],
            "Meat": [],
            "Drinks": [],
            "Baker": [
                Item(name: "Carrot", description: "Delicious Carrot", pricePerKg: 4.99,imageName: "Carrot",category: "Baker",nutritionEffects: "dadadadadadadad"),
                Item(name: "Red Chili", description: "Delicious Chili", pricePerKg: 5.99,imageName: "Red Chili",category: "Baker",nutritionEffects: "dadadadadadadad"),
                Item(name: "Red Chili", description: "Delicious Chili", pricePerKg: 5.99,imageName: "Red Chili",category: "Baker",nutritionEffects: "dadadadadadadad"),
                ]
            
        ]
        var items = ["f1","f2","f3","f1","f2"]
        let fixedSize = 4
        
        @State private var showAllCategories = false
        @State private var showAllSpecialDeals = false
        @StateObject var HomeModel = UserLocation()
        @Binding var selectedCategory: String?
        
        @Binding var cartItems: [CartItems]
        @Binding var cameFromCart: Bool
        @Binding var likedItems: [Item]
        @State var search = ""
        
        @State private var searchItemsViewIsPresented = false
        var body: some View {
            NavigationView {
                ZStack{
                    GeometryReader { geo in
                        VStack(){
                            Spacer(minLength: 240)
                            HStack {
                                Text("Oazis")
                                    .foregroundColor(.white)
                                    .font(.title)
                                Image(systemName: "apple.logo")
                                    .foregroundColor(.white)
                            }
                            HStack(spacing: 15){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                    HStack {
                                        NavigationLink(
                                        destination: SearchItemsView(searchText: $search, items: itemsByCategory.values.flatMap { $0 }),
                                        isActive: $searchItemsViewIsPresented) {
                                            EmptyView()
                                        }
                                        TextField("Search", text: $search)
                                            .padding(.horizontal)
                                            .padding(.vertical, 10)
                                        if search != "" {
                                            Spacer()
                                            Button(action: {
                                                searchItemsViewIsPresented = true
                                            }, label: {
                                                Image(systemName: "magnifyingglass")
                                                    .font(.title2)
                                                    .foregroundColor(.gray)
                                            })
                                            .animation(.easeIn)
                                        }
                                    }
                                }
                                Spacer()
                                HStack {
                                    Image(systemName: "bell")
                                        .resizable()
                                        .frame(width: 25.0,height: 25.0)
                                        .foregroundColor(.white)
                                    
                                }
                            }
                            .padding([.leading,.trailing])
                            HStack(spacing: 15) {
                                Image(systemName: "location")
                                    .foregroundColor(.green)
                                Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                                    .foregroundColor(.black)
                                Text(HomeModel.userAddress)
                                    .font(.caption)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.green)
                            }
                            .frame(width: geo.size.width * 0.6,height: 52)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.top,5)
                            .padding(.bottom, geo.size.height * 0.41)
                            
                        }
                        .frame(height: 330)
                        .background(Color(red: 76 / 255, green: 173 / 255, blue: 115 / 255))
                        .clipShape(CustomBottomCurve(height: 15))
                        .edgesIgnoringSafeArea(.all)
                        .onAppear(perform: {
                            HomeModel.locationManager.delegate = HomeModel
                        })
                        if HomeModel.noLocation {
                            Text("Please enable location access in settings to further move on!!!")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 100,height: 120)
                                .background(Color.white)
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                                .background(Color.black.opacity(0.3).ignoresSafeArea())
                        }
                    }
                    VStack{
                        CustomIndic()
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Categories")
                                        .font(.title3)
                                        .bold()
                                        .padding(.top,15)
                                    Spacer()
                                    
                                    NavigationLink(destination: CategoryItemsView(selectedCategory: $selectedCategory, cartItems: $cartItems, likedItems: $likedItems, cameFromCart: $cameFromCart), isActive: $showAllCategories) {
                                        Button("See All") {
                                            showAllCategories = true
                                        }
                                    }
                                }
                                ScrollView(.horizontal, showsIndicators: false) {
                                    
                                    HStack(spacing: 15){
                                        
                                        ForEach(itemsByCategory.keys.sorted(), id: \.self) { categoryName in
                                            VStack {
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .fill(Color(red: 219/255, green: 243/255, blue: 229/255))
                                                        .frame(width: 65,height: 60)
                                                    Image(categoryName)
                                                        .renderingMode(.original)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 49)
                                                }
                                                Text(categoryName)
                                            }
                                            .onTapGesture {
                                                selectedCategory = categoryName
                                                showAllCategories = true
                                            }
                                            //error here SwiftUI encountered an issue when pushing a NavigationLink. Please file a bug.
                                            
                                            //                                        .background(
                                            //                                            NavigationLink(
                                            //                                                destination: CategoryItemsView(selectedCategory: $selectedCategory),
                                            //                                                    isActive: $showAllCategories,
                                            //                                                    label: { EmptyView() }
                                            //                                                )
                                            //                                            )
                                        }
                                    }
                                }
                                HStack(alignment: .center){
                                    Text("Special Deal")
                                        .font(.title3)
                                        .bold()
                                        .padding(.top,15)
                                    Spacer()
                                    NavigationLink(destination: SpecialDealView(), isActive: $showAllSpecialDeals) {
                                        Button("See All") {
                                            showAllSpecialDeals = true
                                        }
                                    }
                                }
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10){
                                        ForEach(0..<fixedSize, id: \.self) { index in
                                            if index < items.count {
                                                let item = items[index]
                                                VStack {
                                                    Image(item).renderingMode(.original)
                                                    Text(item)
                                                }
                                            } else {
                                                // Placeholder for empty items if the fixed size is larger
                                                VStack {
                                                    Image(systemName: "photo")
                                                    Text("Empty Item")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding([.leading,.trailing])
                        }
                        Spacer()
                    }
                    .padding(.top,190)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    
    
struct SearchItemsView: View {
    @Binding var searchText: String
    var items: [Item]

    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { item in
                return item.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 10),
                    GridItem(.flexible(), spacing: 10),
                ], spacing: 10) {
                    ForEach(filteredItems, id: \.self) { item in
                        // Display the search results in a 2-column grid
                        VStack {
                            Image(item.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipped()
                            Text(item.name)
                        }
                    }
                }
            }
            .navigationTitle("Search Results")
        }
    }
}



    
    
    
    struct CustomBottomCurve: Shape {
        var height: CGFloat
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - height))
            
            let center = CGPoint(x: rect.maxX, y: rect.maxY - height)
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - height), control: CGPoint(x: rect.midX, y: rect.maxY + height))
            
            path.closeSubpath()
            
            return path
        }
    }
    
    #Preview {
        Main()
    }


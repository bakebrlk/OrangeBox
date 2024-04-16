//
//  CategoryItemsView.swift
//  Groceries
//
//  Created by Rauan on 24.10.2023.
//

import SwiftUI

struct CategoryItemsView: View {
    @Binding var selectedCategory: String?
    @State private var itemsByCategory: [String: [Item]] = [
        "Fruit": [],
        "Vegetable": [],
        "Meat": [],
        "Drinks": [],
        "Baker": [
            Item(name: "Carrot", description: "Delicious Carrot", pricePerKg: 4.99,imageName: "Carrot",category: "Baker",nutritionEffects: "dadadadadadadad"),
            Item(name: "Red Chili", description: "Delicious Chili", pricePerKg: 5.99,imageName: "Red Chili",category: "Baker",nutritionEffects: "dadadadadadadad"),
            ]
        
    ]
    
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 2)
    @Binding var cartItems: [CartItems]
    @Binding var likedItems: [Item]
    
    @Binding var cameFromCart: Bool
    @State private var searchText: String = ""

    var filteredItems: [Item] {
        if searchText.isEmpty {
            return itemsByCategory[selectedCategory ?? ""] ?? []
        } else {
            return (itemsByCategory[selectedCategory ?? ""] ?? []).filter { item in
                return item.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            SearchBar(searchText: $searchText)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(itemsByCategory.keys.sorted(), id: \.self) { categoryName in
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectedCategory == categoryName ? Color.green : Color.clear, lineWidth: 5)
                                    .frame(width: 65, height: 60)
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(red: 219/255, green: 243/255, blue: 229/255))
                                    .frame(width: 65, height: 60)
                                Image(categoryName)
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 49)
                            }
                            Text(categoryName)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 45, height: 4)
                                .foregroundColor(selectedCategory == categoryName ? Color.green : Color.clear)
                        }
                        .padding(.top,20)
                        .padding(.leading)
                        .onTapGesture {
                            selectedCategory = categoryName
                        }
                    }
                }
            }
            NavigationLink(destination: CartView(cartItems: $cartItems, selectedCategory: $selectedCategory, likedItems: $likedItems, cameFromCart: $cameFromCart)) {
                HStack {
                    Image(systemName: "cart")
                        .resizable()
                        .frame(width: 30, height: 30) 
                    if cartItems.count > 0 {
                        Text("\(cartItems.count)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(4)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .offset(x: -10,y: -10)
                        
                    }
                }
            }
            if itemsByCategory[selectedCategory ?? ""] != nil {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredItems, id: \.self) { item in
                        NavigationLink(destination: ItemDetailView(item: item, cartItems: $cartItems, itemsByCategory: $itemsByCategory, selectedCategory: $selectedCategory, likedItems: $likedItems, cameFromCart: $cameFromCart)){
                            VStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .frame(width: 170, height: 270)
                                    .overlay(
                                        VStack(alignment: .leading,spacing: 12){
                                            Image(item.name)
                                                .resizable()
                                                .frame(width: 170, height: 100)
                                                .aspectRatio(contentMode: .fit)
                                                .clipped()
                                            Button(action: {
                                                if let index = likedItems.firstIndex(of: item) {
                                                    likedItems.remove(at: index)
                                                } else {
                                                    likedItems.append(item)
                                                }
                                            }) {
                                                Image(systemName: likedItems.contains(item) ? "heart.fill" : "heart")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(likedItems.contains(item) ? .red : .black)
                                            }
                                            Text(item.description)
                                                .font(.headline)
                                                .padding(.leading,10)
                                            
                                            HStack {
                                                Text("$\(String(format: "%.2f", item.pricePerKg))")
                                                    .foregroundColor(.green)
                                                Text("/kg")
                                                    .foregroundColor(.gray)
                                            }
                                            .padding(.leading,16)
                                            Button(action: {
                                                if let selectedCategory = selectedCategory,
                                                   let itemIndex = itemsByCategory[selectedCategory]?.firstIndex(where: { $0.name == item.name }) {
                                                    if let existingCartItemIndex = cartItems.firstIndex(where: { $0.item.name == item.name }) {
                                                        
                                                        // Mark ** Item already exists in the cart, increase quantity
                                                        cartItems[existingCartItemIndex].quantity += 1
                                                    } else {
                                                        //Mark ** Item doesn't exist in the cart, add it
                                                        cartItems.append(CartItems(item: itemsByCategory[selectedCategory]![itemIndex], quantity: 1))
                                                    }
                                                    
                                                }
                                            }) {
                                                Image(systemName: "plus")
                                                    .padding()
                                                    .background(Color.green)
                                                    .foregroundColor(.white)
                                                    .clipShape(Circle())
                                                    .padding(.leading, 110)
                                                    .padding(.bottom, 3)
                                            }
                                        }
                                    )
                            }
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .background(Color.black)
            }
        }
        .navigationBarTitle("All Categories", displayMode: .inline)
        .onAppear {
            updateColumns()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NewItemAdded"))) { _ in
            updateColumns()
        }
    }

    private func updateColumns() {
        let gridItemWidth: CGFloat = 150
        let width = UIScreen.main.bounds.size.width
        let columnsCount = Int(width / gridItemWidth)
        columns = Array(repeating: .init(.flexible(), spacing: 10), count: columnsCount)
    }
}
struct Item: Hashable {
    let name: String
    let description: String
    let pricePerKg: Double
    let imageName: String
    let category: String
    let nutritionEffects: String
}

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .accessibilityLabel("Search")
        }
    }
}


//struct CategoryItemsView_Previews: PreviewProvider {
//    @Binding var selectedCategory: String?
//    @Binding var cartItems: [CartItems]
//    static var previews: some View {
//        CategoryItemsView(selectedCategory: .constant("Baker"), cartItems: .constant(value: ))
//    }
//}

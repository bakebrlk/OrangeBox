//
//  ItemDetailView.swift
//  Groceries
//
//  Created by Rauan on 25.10.2023.
//
import SwiftUI

struct ItemDetailView: View {
    let item: Item
    @Binding var cartItems: [CartItems]
    @Binding var itemsByCategory: [String: [Item]]
    @State private var quantity: Int = 1
    
    @State private var showDescription = true
    @State private var linePosition: CGFloat = 0
    
    var relatedProducts: [Item] {
        return (itemsByCategory[item.category] ?? []).filter { $0.name != item.name }
    }
    @State private var isCartViewActive = false
    @Binding var selectedCategory: String?
    @Binding var likedItems: [Item]
    @Binding var cameFromCart: Bool
    var body: some View {
        VStack{
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.4)
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height * 0.6)
                    VStack{
                        VStack(alignment: .leading,spacing: 0){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 219/255, green: 243/255, blue: 229/255))
                                    .frame(width: 83,height: 25)
                                Text("\(item.category)")
                                    .font(.subheadline)
                                    .foregroundColor(.green)

                                
                            }
                            .padding(.trailing,250)
                            
                            Text(item.name)
                                .font(.title)
                            
                            Text("Price: $\(String(format: "%.2f", item.pricePerKg))/kg")
                                .font(.headline)
                                .foregroundColor(.green)
                            
                        }
                        VStack{
                            HStack {
                                Text("Description")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(showDescription ? .green : .black)
                                    .onTapGesture {
                                        showDescription = true
                                        withAnimation {
                                            linePosition = 0
                                        }
                                    }
                                
                                Text("Nutrition Effects")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(showDescription ? .black : .green)
                                    .onTapGesture {
                                        showDescription = false
                                        withAnimation {
                                            linePosition = UIScreen.main.bounds.width / 2.5
                                        }
                                    }
                            }
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: UIScreen.main.bounds.width / 4, height: 4)
                                .foregroundColor(.green)
                                .offset(x: linePosition - (UIScreen.main.bounds.width / 5), y: -10)
                                .animation(.easeInOut(duration: 0.3))
                        }
                        Divider()
                        if showDescription {
                            Text("\(item.description)")
                                .padding()
                        } else {
                            Text("\(item.nutritionEffects)")
                                .padding()
                        }
                        if !relatedProducts.isEmpty {
                            Text("Related Products")
                                .font(.title)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(relatedProducts, id: \.self) { product in
                                        VStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.white)
                                                .frame(width: 270, height: 150)
                                                .overlay(
                                                    HStack(alignment: .center, spacing: 12) {
                                                        Image(product.imageName)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .clipped()
                                                        HStack {
                                                            VStack{
                                                                Text(product.name)
                                                                    .font(.headline)
                                                                
                                                                HStack{
                                                                    Text("$\(String(format: "%.2f", product.pricePerKg))")
                                                                        .foregroundColor(.green)
                                                                    Text("/kg")
                                                                        .foregroundColor(.gray)
                                                                }
                                                            }
                                                        }
                                                        
                                                    }
                                                )
                                        }
                                    }
                                }
                            }
                            HStack(spacing: 15){
                                Button(action: {
                                    // Decrease quantity
                                    if quantity > 1 {
                                        quantity -= 1
                                    }
                                }) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 76 / 255, green: 173 / 255, blue: 115 / 255), lineWidth: 2)
                                        .frame(width: 30, height: 30)
                                        .overlay(
                                            Image(systemName: "minus")
                                                .font(.title3)
                                                .foregroundColor(Color(red: 76 / 255, green: 173 / 255, blue: 115 / 255))
                                        )
                                }
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text("\(quantity)")
                                            .font(.title2)
                                            .foregroundColor(Color(red: 76 / 255, green: 173 / 255, blue: 115 / 255))
                                    )
                                    .foregroundColor(Color(red: 219/255, green: 243/255, blue: 229/255))
                                
                                Button(action: {
                                    // Increase quantity
                                    quantity += 1
                                }) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 76 / 255, green: 173 / 255, blue: 115 / 255), lineWidth: 2)
                                        .frame(width: 30, height: 30)
                                        .overlay(
                                            Image(systemName: "plus")
                                                .font(.title3)
                                                .foregroundColor(Color(red: 76 / 255, green: 173 / 255, blue: 115 / 255))
                                        )
                                }
                                NavigationLink(destination: CartView(cartItems: $cartItems, selectedCategory: $selectedCategory, likedItems: $likedItems, cameFromCart: $cameFromCart), isActive: $isCartViewActive) {
                                    EmptyView()
                                    Button(action: {
                                        // Add to Cart
                                        cartItems.append(CartItems(item: item, quantity: quantity))
                                    }) {
                                        Text("Add to Cart")
                                            .frame(width: 180)
                                            .padding()
                                            .background(Color(red: 76 / 255, green: 173 / 255, blue: 115 / 255))
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .cornerRadius(10)
                                    }
                                    
                                }
                            }
                            
                            
                        }
                    }
                    .padding(.top,150)
                    .offset(y: -130)
                    .padding([.leading,.trailing])
                    
                    
                }
            .navigationBarTitle("", displayMode: .inline)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

//#Preview {
//    ItemDetailView(item: Item(name: "Sample Item", description: "Sample Description", pricePerKg: 9.99, imageName: "SampleImage",category: "sample",nutritionEffects: "ff"), cartItems: .constant([]))
//}

//
//  CartView.swift
//  Groceries
//
//  Created by Rauan on 25.10.2023.
//

import SwiftUI
import Lottie


struct CartItems: Identifiable {
    let id = UUID()
    let item: Item
    var quantity: Int
}

struct CartView: View {
    @Binding var cartItems: [CartItems]
    @Binding var selectedCategory: String?
    @State private var goToCategoryItemsView = false
    var totalAmount: Double {
        return cartItems.reduce(0) { $0 + ($1.item.pricePerKg * Double($1.quantity)) }
    }
    @Binding var likedItems: [Item]
    @Binding var cameFromCart: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showPlaceOrderSheet = false
    var body: some View {
        NavigationView {
            ScrollView {
                if cartItems.isEmpty {
                    //Mark ** Display a message when the cart is empty
                    VStack {
                        LottieView(loopMode: .loop, name: "cart")
                                .scaleEffect(0.4)
                                .frame(height: 100)
                                .alignmentGuide(.top, computeValue: { dimension in
                                    dimension[.top]
                                })
                                .padding(.top,80)
                                .padding(.bottom,50)
                        Text("Your cart is empty. Please go shopping.")
                            .foregroundColor(.gray)
                            .padding()
                        Button(action: {
                            self.selectedCategory = "Baker"
                            self.cameFromCart = true
                            goToCategoryItemsView = true
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Go Shopping")
                                .frame(width: 200)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                } else {
                    //Mark **  Display cart items
                    ForEach(cartItems) { cartItem in
                        HStack {
                            Image(cartItem.item.imageName)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                            VStack {
                                Text(cartItem.item.name)
                                    .font(.headline)
                                HStack {
                                    Text("$\(String(format: "%.2f", cartItem.item.pricePerKg))")
                                        .foregroundColor(.green)
                                    Text("/kg")
                                        .foregroundColor(.gray)
                                }
                            }

                            Spacer()

                            HStack {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
                                            var updatedCartItems = cartItems
                                            updatedCartItems[index].quantity -= 1
                                            if updatedCartItems[index].quantity <= 0 {
                                                updatedCartItems.remove(at: index)
                                            }
                                            cartItems = updatedCartItems
                                            goToCategoryItemsView = false
                                        }
                                    }
                                Text("\(cartItem.quantity)")
                                    .font(.headline)
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                    .foregroundColor(.green)
                                    .onTapGesture {
                                        if let index = cartItems.firstIndex(where: { $0.id == cartItem.id }) {
                                            var updatedCartItems = cartItems
                                            updatedCartItems[index].quantity += 1
                                            cartItems = updatedCartItems
                                            goToCategoryItemsView = false
                                        }
                                    }
                            }
                        }
                        .padding()
                        .overlay(Divider(), alignment: .bottom)
                    }
                    Button(action: {
                        self.showPlaceOrderSheet.toggle()
                    }) {
                        VStack {
                            Text("Checkout")
                                .font(.headline)
                            Spacer()
                            Text("Total: $\(String(format: "%.2f", totalAmount))")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Cart")
            .navigationBarItems(trailing: NavigationLink(destination: CategoryItemsView(selectedCategory: $selectedCategory, cartItems: $cartItems, likedItems: $likedItems, cameFromCart: $cameFromCart), isActive: $goToCategoryItemsView) {
                EmptyView()
            })
            .fullScreenCover(isPresented: $showPlaceOrderSheet, content: {
                PlaceOrderView(cartItems: $cartItems, priceForDelivery: 0, onClose: {
                    showPlaceOrderSheet = false
                })
            })
        }
    }
}






//#Preview {
//    CartView()
//}

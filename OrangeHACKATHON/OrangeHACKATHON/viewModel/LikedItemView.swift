//
//  LikedItemView.swift
//  Groceries
//
//  Created by Rauan on 27.10.2023.
//

import SwiftUI
import Lottie

struct LikedItemView: View {
    @Binding var likedItems: [Item]
    @Binding var cartItems: [CartItems]
    @Binding var selectedCategory: String?
    @Binding var cameFromCart: Bool
    @Binding var goToCategoryItemsView: Bool
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
                if likedItems.isEmpty {
                    VStack {
                        LottieView(loopMode: .loop, name: "Heart")
                            .scaleEffect(0.2)
                            .frame(height: 50)
                            .padding(.top,100)
                            .padding(.bottom, 150)
                        Text("There's nothing here.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        Button(action: {
                            goToCategoryItemsView = true
                        }) {
                            Text("Go to Shopping")
                                .frame(width: 200)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(10)
                        }
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(likedItems, id: \.self) { item in
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipped()
                                    .frame(width: 100, height: 100)
                                Text(item.name)
                                    .font(.headline)
                                Text("$\(String(format: "%.2f", item.pricePerKg)) / kg")
                                    .foregroundColor(.green)
                                Button(action: {
                                    //Mark **  Remove the item from the liked items
                                    if let index = likedItems.firstIndex(of: item) {
                                        likedItems.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                }
                                Button(action: {
                                    //Mark ** Add the item to the cart
                                    if let existingCartItemIndex = cartItems.firstIndex(where: { $0.item.name == item.name }) {
                                        //Mark ** Item already exists in the cart, increase quantity
                                        cartItems[existingCartItemIndex].quantity += 1
                                    } else {
                                        //Mark ** Item doesn't exist in the cart, add it
                                        cartItems.append(CartItems(item: item, quantity: 1))
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                }
            }
            .background(
                NavigationLink("", destination: CategoryItemsView(selectedCategory: $selectedCategory, cartItems: $cartItems, likedItems: $likedItems, cameFromCart: $cameFromCart), isActive: $goToCategoryItemsView)
                )
            .padding()
            .navigationBarTitle("Liked Items")
        }
    }
}

struct LottieView2: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let name: String
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> some UIView{
        
        let view = UIView()
        let animationView = LottieAnimationView(name: name)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return view
    }
}
struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let name: String
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}



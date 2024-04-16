//
//  CustomIndic.swift
//  Groceries
//
//  Created by Rauan on 22.10.2023.
//

import SwiftUI

struct CustomIndic: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let images: [String] = ["top", "top", "top","top"]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .frame(width: 290)
                        .cornerRadius(25)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                        .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(images.count - 1, currentIndex + 1)
                            }
                        }
                    }
            )
            
            HStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Capsule()
                        .fill(Color.green)
                        .frame(width: currentIndex == index ? 20 : 7, height: 7)
                        .animation(.spring())
                }
            }
            .padding(.top, 30)
            .padding(.trailing,250)
        }
    }
}



#Preview {
    CustomIndic()
}

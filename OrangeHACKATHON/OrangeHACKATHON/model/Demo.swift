//
//  Demo.swift
//  Groceries
//
//  Created by Rauan on 07.11.2023.
//
import SwiftUI
import Lottie

enum OrderStatus: String, CaseIterable {
    case pending = "Pending"
    case accepted = "Accepted"
    case way = "On The Way"
    case delivered = "Delivered"
}

struct Demo: View {
    @State private var containerWidth: CGFloat = 0
    @State private var progressTitle: String = OrderStatus.pending.rawValue

    var maxWidth: CGFloat {
        return min(containerWidth / CGFloat(OrderStatus.allCases.count - 1) * CGFloat(currentIndex), containerWidth)
    }

    private let orderStatuses: [OrderStatus] = [.pending, .accepted, .way, .delivered]
    @State private var currentIndex = 0

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundColor(.clear)
                        .onAppear {
                            containerWidth = geo.size.width
                        }
                }
                RoundedRectangle(cornerRadius: 60)
                    .stroke(Color.black, lineWidth: 1)

                ZStack(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.green)

                    Text("\(progressTitle)")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                        .background(
                            RoundedRectangle(cornerRadius: 60)
                                .fill(Color.yellow)
                        )
                }
                .padding(2)
                .frame(minWidth: maxWidth)
                .fixedSize()
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(20)

            HStack {
                ForEach(orderStatuses, id: \.self) { status in
                    VStack(alignment: .center){
                        if status == .pending && currentIndex == 0 {
                            LottieView2(loopMode: .loop, name: "pending")
                                .padding(.leading,40)
                                .scaleEffect(3)
                        } else if status == .accepted && currentIndex == 1 {
                            LottieView2(loopMode: .loop, name: "accepted")
                                .scaleEffect(2)
                        } else if status == .way && currentIndex == 2 {
                            LottieView2(loopMode: .loop, name: "deliver")
                                .scaleEffect(3)
                                .padding(.trailing,50)
                        } else if status == .delivered && currentIndex == 3 {
                            LottieView2(loopMode: .loop, name: "delivered")
                                .scaleEffect(3)
                                .padding(.trailing,70)
                        }
                    }
                    .padding()
                }
            }
            .padding()

            Button("Next Status") {
                guard currentIndex < orderStatuses.count - 1 else { return }

                withAnimation(.linear(duration: 0.5)) {
                    currentIndex += 1
                }

                progressTitle = orderStatuses[currentIndex].rawValue
            }
            .tint(Color.red)
        }
    }
}


#Preview {
    Demo()
}




//struct Demo: View {
//    let items: [String] = ["Carrot", "Chili", "Broccoli", "Tomato", "Potato", "Lettuce"]
//    @State private var selectedQuantity: Double = 0.0
//
//    var body: some View {
//        VStack {
//            Text("\(selectedQuantity, specifier: "%.1f") kg")
//                .font(.title)
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
//                    ForEach(items, id: \.self) { item in
//                        CategoryItemView(item: item, isSelected: selectedQuantity > 0)
//                            .onTapGesture {
//                                // Handle item selection here
//                                if selectedQuantity == 0 {
//                                    selectedQuantity = 0.5 // Set a default quantity
//                                }
//                            }
//                    }
//                }
//            }
//            .padding(.horizontal)
//
//            Spacer()
//        }
//        .navigationTitle("Category Items")
//    }
//}

//struct CategoryItemView: View {
//    let item: String
//    let isSelected: Bool
//
//    var body: some View {
//        VStack {
//            Text(item)
//                .font(.headline)
//                .padding()
//                .background(isSelected ? Color.blue : Color.gray)
//                .foregroundColor(.white)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
//
//            if isSelected {
//                Text("Remove")
//                    .font(.caption)
//                    .foregroundColor(.white)
//                    .padding(.vertical, 4)
//                    .background(Color.red)
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
//            }
//        }
//    }
//}
//
//extension Comparable {
//    func clamped(to range: ClosedRange<Self>) -> Self {
//        return min(max(self, range.lowerBound), range.upperBound)
//    }
//}

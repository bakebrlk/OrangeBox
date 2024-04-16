//
//  SpecialDealView.swift
//  Groceries
//
//  Created by Rauan on 24.10.2023.
//

import SwiftUI

struct SpecialDealView: View {
    @State private var items = ["f1", "f2", "f3", "Breads", "Fish", "Fruits","Vegetable"]
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    VStack {
                        Image(item)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                        Text(item)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .padding()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 219/255, green: 243/255, blue: 229/255))
                        .frame(width: 60,height: 60)
                    Image("Vegetable")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45)
                }
            }
        }
        .navigationBarTitle("All Special Deals", displayMode: .inline)
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


#Preview {
    SpecialDealView()
}

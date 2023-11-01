//
//  PlaceOrderView.swift
//  Groceries
//
//  Created by Rauan on 01.11.2023.
//

import SwiftUI


struct PlaceOrderView: View {
    @State private var selectedDate: String = "1 November"
    @State private var selectedTime: String = "10:00 to 12:00"
    @State private var customerName: String = ""
    @State private var commentary: String = ""
    @State private var paymentMethod: String = "Credit Card"
    @Binding var cartItems: [CartItems]
    
    var priceForDelivery: Double
    var totalAmount: Double { return calculateSumOfOrder() + priceForDelivery }
    
    var dateOptions = ["1 November", "2 November", "3 November"]
    var timeOptions = ["10:00 to 12:00", "14:00 to 17:00", "19:00 to 22:00"]
    
    var onClose: () -> Void
    var body: some View {
        VStack(alignment: .leading){
                Button(action: {
                    onClose()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 20, height: 20)
                }
                .offset(x: -10,y: -40)
            Text("Delivery Address")
                .font(.headline)
                .padding()
            
            Text("Date of Delivery:")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(dateOptions, id: \.self) { date in
                        Text(date)
                            .padding()
                            .background(selectedDate == date ? Color.green : Color.gray)
                            .foregroundColor(selectedDate == date ? Color.white : Color.black)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedDate = date
                            }
                    }
                }
            }
            
            Text("Time of Delivery:")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(timeOptions, id: \.self) { time in
                        Text(time)
                            .padding()
                            .background(selectedTime == time ? Color.green : Color.gray)
                            .foregroundColor(selectedTime == time ? Color.white : Color.black)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTime = time
                            }
                    }
                }
            }
            
            Text("Customer Information")
                           .font(.headline)
                           .padding()
                       
            TextField("Name", text: $customerName)
            TextField("Contact Information (Commentary)", text: $commentary)
                       
                       Text("Payment Method:")
            Picker(selection: $paymentMethod, label: Text("")) {
                Text("Credit Card").tag("Credit Card")
                Text("Cash on Delivery").tag("Cash on Delivery")
                Text("PayPal").tag("PayPal")
                // Add more payment options as needed
            }
                       
            Text("Order Summary")
                .font(.headline)
                .padding()
                       
            Text("Sum of Order: $\(String(format: "%.2f", calculateSumOfOrder()))")
            Text("Price for Delivery: $\(String(format: "%.2f", priceForDelivery))")
            Text("Total Amount: $\(String(format: "%.2f", totalAmount))")
                       
            Button(action: {
                
            }) {
                Text("Accept Order")
                    .frame(width: 200)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Place Order")
    }
    func calculateSumOfOrder() -> Double {
            return cartItems.reduce(0) { $0 + ($1.item.pricePerKg * Double($1.quantity)) }
        }
}


//#Preview {
//    PlaceOrderView(sumOfOrder: 24.2, priceForDelivery: 44.2)
//    
//}

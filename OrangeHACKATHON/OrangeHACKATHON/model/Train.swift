//
//  Train.swift
//  Groceries
//
//  Created by Rauan on 01.11.2023.
//

import SwiftUI

struct Train: View {
    @State private var selectedDate: String = "1 November"
    @State private var selectedTime: String = "10:00 to 12:00"
    @State private var customerName: String = ""
    @State private var commentary: String = ""
    @State private var paymentMethod: String = "Credit Card"
    @State private var contactlessDelivery = false
    @State private var selectedPaymentMethod: String = "Cash on Delivery"
    @State private var isPaymentMethodSheetPresented = false
    
    var priceForDelivery: Double = 24.0
    var total: Double = 34.0
    var totalAmount: Double { return total + priceForDelivery }
    
    var dateOptions = ["1 November", "2 November", "3 November"]
    var timeOptions = ["10:00 to 12:00", "14:00 to 17:00", "19:00 to 22:00"]
    
    //    var onClose: () -> Void
    @State private var paymentMethods: [String] = ["Cash on Delivery"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 35){
                HStack(alignment: .center,spacing: 100){
                    Button(action: {
                        //                    onClose()
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 20, height: 20)
                    }
                    Text("Placing order")
                        .font(.title3)
                        .bold()
                }
                //            .offset(x: 0,y: -40)
                VStack(alignment: .leading,spacing: 15){
                    Text("Delivery Address")
                        .font(.title2)
                        .bold()
                    Text("SDU")
                        .font(.title3)
                }
                
                VStack(alignment: .leading,spacing: 20){
                    Text("Date of Delivery:")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(dateOptions, id: \.self) { date in
                                Text(date)
                                    .padding()
                                    .background(selectedDate == date ? Color(red: 219/255, green: 243/255, blue: 229/255) : Color(red: 245/255,green: 245/255,blue: 245/255))
                                    .foregroundColor(selectedDate == date ? Color.green : Color.black)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedDate = date
                                    }
                            }
                        }
                    }
                }
                VStack(alignment: .leading,spacing: 20) {
                    Text("Time of Delivery:")
                        .font(.title2)
                        .bold()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(timeOptions, id: \.self) { time in
                                Text(time)
                                    .padding()
                                    .background(selectedTime == time ? Color(red: 219/255, green: 243/255, blue: 229/255) : Color(red: 245/255,green: 245/255,blue: 245/255))
                                    .foregroundColor(selectedTime == time ? Color.green : Color.black)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedTime = time
                                    }
                            }
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 20) {
                    Text("Customer Information")
                        .font(.title2)
                        .bold()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1) // Gray border
                            .background(Color.white) // White fill
                        
                        TextField("Name", text: $customerName)
                            .padding(15)
                            .foregroundColor(.gray) // Text color
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1) // Gray border
                            .background(Color.white) // White fill
                        
                        TextField("Contact Information (Commentary)", text: $commentary)
                            .padding(15)
                            .foregroundColor(.gray) // Text color
                    }
                }
                VStack(alignment: .leading, spacing: 20){
                    HStack(spacing: -60){
                        VStack(alignment: .leading,spacing: 10){
                            Text("Сontactless delivery:")
                                .font(.title2)
                                .bold()
                            Text("Please, leave my order at the \ndoor")
                            
                                .font(.headline)
                                .foregroundStyle(.gray)
                        }
                        Spacer()

                        Toggle("", isOn: $contactlessDelivery)
                            .toggleStyle(SwitchToggleStyle(tint: contactlessDelivery ? .green : .red))
                    }
                    
                }
                VStack(alignment: .leading, spacing: 20) {
                    Text("Payment Method:")
                        .font(.title2)
                        .bold()
                    Button(action: {
                        isPaymentMethodSheetPresented.toggle()
                    }) {
                        HStack {
                            Text(selectedPaymentMethod)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                    }
                }
                .sheet(isPresented: $isPaymentMethodSheetPresented) {
                    PaymentMethodSheet(selectedPaymentMethod: $selectedPaymentMethod, isPaymentMethodSheetPresented: $isPaymentMethodSheetPresented, paymentMethods: $paymentMethods)
                        .presentationDetents([.height(300)])
                }
                VStack(spacing: 30){
                    Text("Order Summary")
                        .font(.headline)
                    HStack{
                        Text("Sum of Order: ")
                        Spacer()
                        Text("$\(String(format: "%.2f", total))")
                    }
                    HStack{
                        Text("Price for Delivery: ")
                        Spacer()
                        Text("$\(String(format: "%.2f", priceForDelivery))")
                    }
                    HStack{
                        Text("Total Amount: ")
                        Spacer()
                        Text("$\(String(format: "%.2f", totalAmount))")
                    }
                    
                    Button(action: {
                        
                    }) {
                        Text("Accept Order")
                            .frame(width: 300)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Place Order")
        }
    }
    //    func calculateSumOfOrder() -> Double {
    //            return cartItems.reduce(0) { $0 + ($1.item.pricePerKg * Double($1.quantity)) }
    //        }
}



#Preview {
    Train()
}

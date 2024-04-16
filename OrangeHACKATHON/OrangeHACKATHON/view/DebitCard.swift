//
//  DebitCard.swift
//  Groceries
//
//  Created by Rauan on 05.11.2023.
//

import SwiftUI

struct DebitCard: View {
    // View Properties
    @FocusState private var activeTF: ActiveKeyboardField!
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var cvvCode: String = ""
    @State private var expireDate: String = ""
    private let characterLimit = 16
    var onClose: () -> Void
    
    @Binding var paymentMethods: [String]
    @Binding var selectedPaymentMethod: String
    var body: some View {
        NavigationStack {
            VStack {
                // Header View
                HStack {
                    Button {
                        onClose()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                    Text("Add Card")
                        .font(.title3)
                        .padding(.leading, 10)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title2)
                    }
                }
                
                // Card View
                CardView()
                
                Spacer(minLength: 0)
                
                Button {
                    let last4Digits = String(cardNumber.suffix(4))
                    let maskedCardNumber = String(repeating: "*", count: cardNumber.count - 4) + last4Digits
                    let newCard = "Card Number: \(maskedCardNumber)"
                        
                        // Append the new card to the paymentMethods
                        paymentMethods.append(newCard)

                        // Close the AddCardView
                        onClose()
                } label: {
                    Label("Add Card", systemImage: "lock")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue.gradient)
                        }
                }
                // Disabling Action, Until All Details have been Completely Filled
                .disableWithOpacity(cardNumber.count != 19 || expireDate.count != 5 || cardHolderName.isEmpty || cvvCode.count != 3)

            }
            .padding()
            .toolbar(.hidden, for: .navigationBar)
            // Keyboard Change Button
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    // No Button Needed for Last Item
                    if activeTF != .cardHolderName {
                        Button ("Next") {
                            switch activeTF {
                            case .cardNumber:
                                activeTF = .expirationDate
                            case .cardHolderName: break
                            case .expirationDate:
                                activeTF = .cvv
                            case .cvv:
                                activeTF = .cardHolderName
                            case .none: break
                            }
                        }
                        .tint(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [
                    .green,
                    
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
        
            // Card Details
            VStack(spacing: 10) {
                HStack {
                    TextField("XXXX XXXX XXXX XXXX", text: $cardNumber)
                        .font(.title3)
                        .keyboardType(.numberPad)
                        .focused($activeTF, equals: .cardNumber)
                        .onChange(of: cardNumber) { newValue in
                            cardNumber = formatCardNumber(newValue)
                        }
                    
                    Spacer(minLength: 0)
                    
                    Image("Visa")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                }
                
                HStack(spacing: 12) {
                    TextField("MM/YY", text: $expireDate)
                        .keyboardType(.numberPad)
                        .focused($activeTF, equals: .expirationDate)
                        .onChange(of: expireDate) { newValue in
                            if newValue.count > 5 {
                                expireDate = String(newValue.prefix(5))
                            } else if newValue.count == 2 && !newValue.contains("/") {
                                expireDate += "/"
                            } else if newValue.count == 3 && newValue.last != "/" {
                                expireDate.removeLast()
                            }
                        }

                    
                    Spacer(minLength: 0)
                    
                    TextField("CVV", text: $cvvCode)
                        .frame(width: 35)
                        .focused($activeTF, equals: .cvv)
                        .keyboardType(.numberPad)
                        .onChange(of: cvvCode) { newValue in
                            cvvCode = String(newValue.prefix(3))
                        }
                    
                    Image(systemName: "questionmark.circle.fill")
                }
                .padding(.top, 15)
                
                Spacer(minLength: 0)
                
                TextField("CARD HOLDER NAME", text: $cardHolderName)
                    .focused($activeTF, equals: .cardHolderName)
                    .submitLabel(.done)
                
            }
            .padding(20)
            .environment(\.colorScheme, .dark)
            .tint(.white)
        }
        .frame(height: 200)
        .padding(.top, 35)
    }
    func formatCardNumber(_ value: String) -> String {
        var formattedNumber = ""
        
        let numericValue = String(value.filter { $0.isNumber }.prefix(16))
        
        for (index, digit) in numericValue.enumerated() {
            if index > 0 && index % 4 == 0 {
                formattedNumber += " "
            }
            formattedNumber.append(digit)
        }
        
        return formattedNumber
    }
}

enum ActiveKeyboardField: Hashable{
    case cardNumber
    case cardHolderName
    case expirationDate
    case cvv
}

extension View {
    @ViewBuilder
    func disableWithOpacity(_ status: Bool) -> some View {
        self
            .disabled(status)
            .opacity(status ? 0.6 : 1)
    }
}
//#Preview {
//    DebitCard()
//}

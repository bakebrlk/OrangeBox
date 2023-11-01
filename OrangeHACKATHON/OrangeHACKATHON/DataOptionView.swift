//
//  DataOptionView.swift
//  Culinary Oasis
//
//  Created by bakebrlk on 31.10.2023.
//

import SwiftUI

struct DataOptionView: View {
    
    @Binding var optionDetails: ProfileData
    @Binding var description: String
    @Binding var title: String
    @Binding var shareSheet: Bool
    @State private var textField: String = ""

    
    var body: some View {
        NavigationView{
            
            VStack{
                TextField
                btn
            }
            .navigationBarTitle(title, displayMode: .inline)
            
        }
    }
    
    private var TextField: some View  {
        
        SwiftUI.TextField(text: $textField) {
            VStack(alignment: .leading){
                Text(description)
            }
        }
        .textFieldStyle(OutlinedTextFieldStyle())
        .padding()
    }
    
    private var btn: some View  {
        Button(action: {
            optionDetails = .none
            shareSheet.toggle()
        }, label: {
            HStack{
                Spacer()
                
                Text("Dismiss")
                    .foregroundStyle(Color.white)
                    .bold()
                    .padding()
                
                Spacer()
           
            }
            .background(Color.green)
            .cornerRadius(16)
            .padding()
        })
        
    }
    
    
}

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}

#Preview {
    DataOptionView(optionDetails: .constant(.phone), description: .constant("title"), title: .constant("da"), shareSheet: .constant(false))
    
}



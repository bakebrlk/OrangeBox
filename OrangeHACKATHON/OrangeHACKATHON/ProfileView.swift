//
//  ProfileView.swift
//  Culinary Oasis
//
//  Created by bakebrlk on 26.10.2023.
//

import SwiftUI

enum ProfileData: String {
    
    case none
    case name
    case avatar
    case phone
    case email
    case cart
    case address
    
}

struct ProfileView: View {
    
    @State private var optionsDetails: ProfileData = .none
    @State private var shareSheet: Bool = false
    @State private var avatar: Image = Image(systemName: "person.crop.circle")
    @State private var fullName: String = "Bekzat Birlik"
    @State private var phone: String = "+7 700 241 9495"
    @State private var email: String = "bekzatbirlik@gmail.com"
    @State private var cart: Image = Image("visa")
    @State private var address: String = "Алматы, Жунисова 4/6 1 под, 36кв"
    @State private var titleForOption = ""
    @State private var descriptionForOption = ""
    
    
    var body: some View {
        
        VStack{
                
            title
            
            profileImage
            
            
            fullNameView
                    
            posts
            
            Spacer()
        }
    
    }
    
    private var fullNameView: some View {
        description(text: fullName)
            .font(.title2)
            .onTapGesture {
                optionsDetails = .name
                shareSheet.toggle()
                titleForOption = "Full Name"
                descriptionForOption = fullName
            }
            .sheet(isPresented: $shareSheet, content: {
                DataOptionView(optionDetails: $optionsDetails, description: $descriptionForOption, title: $titleForOption, shareSheet: $shareSheet)
                    .presentationDetents([.medium])
            })
    }
    
    private var posts: some View {
        VStack{
            post(title: "Телефон", description: phone, profileData: .phone)
            post(title: "E-mail", description: email, profileData: .email)
            post(title: "карта", description: "visa", profileData: .cart)
            post(title: "адрес", description: address, profileData: .address)
            
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
        .padding()
    }
    
    private func post(title: String, description: String, profileData: ProfileData) -> Button<some View>{
        
        Button(action: {
            optionsDetails = profileData
            shareSheet.toggle()
            titleForOption = title
            descriptionForOption = description
            
        }, label: {
            HStack{
                titleInfo(text: title)
                   
                
                Spacer()
                if(profileData == .cart){
                    cart.padding()
                    
                }else{
                    self.description(text: description)
                }
            }
            .sheet(isPresented: $shareSheet, content: {
                DataOptionView(optionDetails: $optionsDetails, description: $descriptionForOption, title: $titleForOption, shareSheet: $shareSheet)
                    .presentationDetents([.medium])
            })
            
        })
        
        
    }
    
    private func titleInfo(text: String) -> some View{
        Text(text)
            .foregroundStyle(Color.gray)
            .padding()
    }
    
    private func description(text: String) -> some View{
        Text(text)
            .bold()
            .fontWidth(.compressed)
            .foregroundStyle(Color.black)
            .padding()
    }
    
    private var title: some View = {
        Text("Profile")
            .bold()
            .fontWidth(.condensed)
            .padding()
    }()
    
    private var profileImage: some View {
        
        avatar
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .foregroundStyle(Color.blue)
            .padding()
        
    }
    
}


#Preview {
    ProfileView()
}

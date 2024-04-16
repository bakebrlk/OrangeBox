//
//  UserProfileView.swift
//  Groceries
//
//  Created by Rauan on 26.10.2023.
//

import SwiftUI


struct UserProfileView: View {
    var body: some View {
        
        VStack{
                
            title
            
            profileImage
            
            description(text: "Rauan Gadil")
                .font(.title2)
                
                    
            posts
            
            Spacer()
        }
    
    }
    
    private var posts: some View {
        VStack{
            post(title: titleInfo(text: "Телефон"), description: description(text: "+7 700 241 9495"))
            post(title: titleInfo(text: "E-mail"), description: description(text: "bekzatbirlik@gmail.com"))
            post(title: titleInfo(text: "карта"), description:  Image("visa").padding())
            post(title: titleInfo(text: "адрес"), description: description(text: "Алматы, Жунисова 4/6 1 под, 36кв"))
            
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
        .padding()
    }
    
    private func post(title: some View, description: some View) -> some View{
        HStack{
            title
               
            
            Spacer()
            description
        }
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
            .padding()
    }
    
    private var title: some View = {
        Text("Profile")
            .bold()
            .fontWidth(.condensed)
            .padding()
    }()
    
    private var profileImage: some View = {
        
        Image(systemName: "person.crop.circle")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .padding()
        
    }()
    
}


#Preview {
    UserProfileView()
}


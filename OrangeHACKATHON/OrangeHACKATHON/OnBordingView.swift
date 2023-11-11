//
//  OnBordingView.swift
//  Culinary Oasis
//
//  Created by bakebrlk on 02.11.2023.
//

import SwiftUI
import Lottie

struct OnBordingView: View {
    
    @State private var backgroundImages = [Image("onBording1"),Image("onBording2"),Image("onBording3")]
    @State private var index = 0
    @State private var title: [String] = ["Your One stop Online Market"]
    @State private var descriptions: [String] = ["Don't need to go outside everyday for your grocery items."]

    
    var body: some View {
        
        
        VStack{
            Spacer()
            
            backgroundImageView
            
            titleView
            descriptionView
            
            Spacer()
            btn
                .padding(.bottom)
           
        }
        .background(Color.green)
        .edgesIgnoringSafeArea(.all)

    }
    
    private var btn: some View {
        Button {
            print("")
        } label: {
            Text("Next")
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .padding()

    }
    
    private var titleView: some View {
        Text(title[index])
            .bold()
            .font(.title)
            .padding([.leading, .trailing])
        
    }
    
    
    private var descriptionView: some View {
        Text(descriptions[index])
            .font(.title3)
            .padding([.leading, .trailing, .top])
        
    }
    
    private var backgroundImageView: some View{
    
        LottieView( loopMode: .loop, name: "onBording1")
            .scaleEffect(0.6)
            .frame(height: 400)
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

#Preview {
    OnBordingView()
}

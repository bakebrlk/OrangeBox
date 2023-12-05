//
//  OnBordingView.swift
//  Culinary Oasis
//
//  Created by bakebrlk on 02.11.2023.
//

import SwiftUI
import Lottie

private enum statusForLottieView {
    case onBording1
    case onBording2
    case onBording3
    
}

struct OnBordingView: View {
    
    @State private var isNextPage = false
    @State private var index = 0
    @State private var title: [String] = [
        "Добро пожаловать на Culinary Oasis",
        "Исследуйте, открывайте, процветайте вместе с Culinary Oasis",
        "Улучшите качество покупок в Culinary Oasis"
    ]
    @State private var descriptions: [String] = [
        "Отправьтесь в увлекательное путешествие с Culinary Oasis идеальным пунктом назначения для всех ваших потребностей.",
        "Откройте для себя уникальные сокровища, общайтесь с увлеченными продавцами и испытайте радость от безупречных транзакций.",
        "Наша удобная торговая площадка предоставит вам широкий спектр продуктов и услуг, обеспечивая индивидуальный подход именно для вас."
    ]
    
    
    var body: some View {
        
        NavigationView{
            
            
            VStack{
                NavigationLink(" ", destination: HostingSwiftUItoUIkitController().navigationBarBackButtonHidden(true).ignoresSafeArea(), isActive: $isNextPage)
                    
                    
                backgroundImageView
                
                titleView
                
                descriptionView
                
                Spacer()
                btn
            }
            
            .background(Color.green)

        }
  
    }
    
    private var btn: some View {
        
        Button {
            if(index < 2){
                index += 1
            }else{
                isNextPage.toggle()
                print(isNextPage)
            }
        } label: {
            Text("Next")
                .font(.body)
                .foregroundStyle(Color.black)
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
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var descriptionView: some View {
        Text(descriptions[index])
            .font(.headline)
            .padding(10)
            .frame(alignment: .leading)
        
    }
    
    private var backgroundImageView: some View{
        
        VStack{
            
            if(index == 0){
                LottieView(loopMode: .loop, name: "onBording1")
                    .scaleEffect(0.9)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }else if(index == 1){
                LottieView(loopMode: .loop, name: "onBording2")
                    .scaleEffect(0.6)
            }else {
                LottieView(loopMode: .loop, name: "onBording3")
                    .scaleEffect(0.6)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
}

struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let name: String
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView{
        
        let view = UIView()
        let animationView = LottieAnimationView(name: name)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return view
    }
    
    
}

#Preview {
    OnBordingView()
}

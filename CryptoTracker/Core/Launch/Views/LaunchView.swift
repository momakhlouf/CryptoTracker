//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 25/05/2023.
//

import SwiftUI

struct LaunchView: View {
    @State private var launchText : [String] = "Loading your portfolio...".map{String($0)}
    @State private var showingLaunchText : Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter : Int = 0
    @State private var loops : Int = 0
    @Binding  var showingLaunchView : Bool

    var body: some View {
        ZStack{
        Color.launch.launchBackground
            .ignoresSafeArea()
  
            Image("bitcoin")
                .resizable()
                .frame(width: 100 , height: 100)
            
            ZStack{
                if showingLaunchText {
                    HStack(spacing: 0){
                        ForEach(launchText.indices , id: \.self){ index in
                            Text(launchText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(.launch.launchAccent)
                                .offset(y : counter == index ? -7 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))

                }
            }
            .offset(y : 70)
        }
        .onAppear{
            showingLaunchText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = launchText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2{
                        showingLaunchView = false
                    }
                    
                }else{
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showingLaunchView: .constant(true))
    }
}

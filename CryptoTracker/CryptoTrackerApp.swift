//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject var vm = HomeViewModel()
    @State private var showingLaunchView : Bool = true

    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            
            ZStack{
                NavigationStack{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack{
                    if showingLaunchView {
                        LaunchView(showingLaunchView: $showingLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            
        }
    }
}

//
//  HomeStatesView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 13/04/2023.
//

import SwiftUI

struct HomeStatesView: View {
    
    @EnvironmentObject var vm : HomeViewModel
    
    @Binding var showPortfolio : Bool
    var body: some View {
        HStack{
            ForEach(vm.statistics){ state in
                StatisticsView(stat: state)
            }
            .frame(width: UIScreen.main.bounds.width / 3)
        }
        .frame(width: UIScreen.main.bounds.width , alignment: showPortfolio ? .trailing : .leading)
        
        if showPortfolio {
            
        }
    }
}

struct HomeStatesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatesView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}

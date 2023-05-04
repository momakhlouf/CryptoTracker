//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showProfile : Bool = false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                homeHeader
                
                HomeStatesView(showPortfolio: $showProfile)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                
                if !showProfile {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showProfile{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView{
    private var homeHeader : some View{
        HStack{
            CircleButtonView(iconName: showProfile ? "plus" : "info")
                .animation(.none)
                .background{
                    CircleButtonAnimateView(animate: $showProfile)
                }
            Spacer()
            Text(showProfile ? "Profile" : "Live Prices")
                .animation(.none)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProfile ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showProfile.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var columnTitles : some View {
        HStack{
            Text("Coin")
            Spacer()
            if showProfile {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }

    private var allCoinsList : some View {
        List{
            ForEach(vm.coins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
           }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList : some View {
        List{
            CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumn: true)
                .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        }
        .listStyle(.plain)
    }
}

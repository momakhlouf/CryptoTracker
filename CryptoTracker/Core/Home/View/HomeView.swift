//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showProfile : Bool = false //Animate right
    @State private var showProfileSheet : Bool = false //show sheet
    @State private var selectedCoin : CoinModel? = nil
    @State private var showDetailsView : Bool = false
   

    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showProfileSheet) {
                    PortfolioView()
                        .environmentObject(vm)
                    //because sheet is a new environment.
                }
            VStack{
                homeHeader
                
                HomeStatesView(showPortfolio: $showProfile)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                
                if !showProfile {
                    allCoinsList
                        .transition(.move(edge: .leading))
                        .refreshable {
                            vm.refreshData()
                            print(vm.coins.first?.currentPrice ?? 0)
                            print("refresh")
                        }
                }
                if showProfile{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                       
                }
                Spacer(minLength: 0)
            }
        }
        .background{
            NavigationLink(destination: DetailsLoadingView(coin: $selectedCoin ), isActive: $showDetailsView) {
                EmptyView()
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
                .onTapGesture {
                    if showProfile {
                        showProfileSheet.toggle()
                    }
                }
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
            HStack{
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .reversedRank ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOption = vm.sortOption == .rank ? .reversedRank : .rank
                }
            }
            
            Spacer()
            if showProfile {
                Text("Holdings")
            }
            HStack{
                Text("price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
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
                        .onTapGesture {
                            segue(coin: coin)
                        }
           }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList : some View {
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                }
            }
        }
                    .listStyle(.plain)
    }
    
    private func segue(coin : CoinModel){
        selectedCoin = coin
        showDetailsView .toggle()
    }
}

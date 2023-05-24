//
//  DetailsView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2023.
//

import SwiftUI


struct DetailsLoadingView: View {
    @Binding var coin : CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    @StateObject private var vm : DetailsViewModel
    private let columns : [GridItem] = [GridItem(.flexible()) , GridItem(.flexible())]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailsViewModel(coin: coin))
    }
    var body: some View {
        ScrollView{
            VStack{
                Text("")
                    .frame(height: 150)
                
                overViewTitle
                Divider()
                overViewGrid
                additionalTitle
                Divider()
                additionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
             navigationBarTrailing
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailsView(coin: dev.coin)
        }
    }
}


extension DetailsView {
    
    private var navigationBarTrailing : some View {
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            
            AsyncImage(url: URL(string: vm.coin.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            } placeholder: {
                ProgressView()
            }
        }
    }
    
    private var overViewTitle : some View {
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity , alignment: .leading)
    }
    
    private var additionalTitle : some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity , alignment: .leading)
    }
    
    
    private var overViewGrid : some View {
        LazyVGrid(columns: columns , alignment: .leading , spacing: 30){
            ForEach(vm.overViewStatistics){ stat in
                StatisticsView(stat: stat)
            }
        }
    }
    
    private var additionalGrid : some View {
        LazyVGrid(columns: columns , alignment: .leading , spacing: 30){
            ForEach(vm.additionalStatistics){ stat in
                StatisticsView(stat: stat)
            }
        }
        
    }
    
}

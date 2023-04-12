//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 09/04/2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingColumn : Bool
    var body: some View {
        HStack{
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
            
            rightColumn
         
        }
        .font(.subheadline)
       // .padding()
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
    }
}

extension CoinRowView {
    private var leftColumn : some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            } placeholder: {
                ProgressView()
            }

//            Circle()
//                .frame(width: 30 , height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn : some View{
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.currencyFormat())
            Text((coin.currentHoldings ?? 0).numberStringFormat())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.currencyFormat())
                .bold()
            Text(coin.priceChangePercentage24H?.percentStringFormat() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                        Color.theme.red
                )
        }
        // spacer() not enough because if the number digits are small , the ui will be not responsive.
            .frame(width: UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
    }
    
    
}

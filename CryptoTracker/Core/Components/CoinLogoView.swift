//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 04/05/2023.
//

import SwiftUI

struct CoinLogoView: View {
    let coin : CoinModel

    var body: some View {
        VStack{
            CoinImageView(coin: coin)
//            AsyncImage(url: URL(string: coin.image)) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50, height: 50)
//            } placeholder: {
//                ProgressView()
//            }
//            Circle()
//                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
    }
}

//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 27/05/2023.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm : CoinImageViewModel
    
    init(coin : CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 30 , height: 30)
            }else if vm.isLoading {
                ProgressView()
            }else {
                Image(systemName: "photo.circle")
                    .resizable() 
                    .foregroundColor(.theme.secondaryText)
                    .frame(width: 30 , height: 30)
            }
          
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}

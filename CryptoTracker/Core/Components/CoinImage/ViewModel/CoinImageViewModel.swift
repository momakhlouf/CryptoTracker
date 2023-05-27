//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 28/05/2023.
//

import Foundation
import Combine
import SwiftUI

class CoinImageViewModel : ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading : Bool = false
    
    private let coin : CoinModel
    private let dataService : CoinImageServices
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel){
        self.coin = coin
        self.dataService = CoinImageServices(coin: coin)
        self.isLoading = true
        getImage()
    }
    
    func getImage(){
        dataService.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}

//
//  CoinImageServices.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 27/05/2023.
//

import Foundation
import Combine
import SwiftUI

class CoinImageServices {
    
    @Published var image : UIImage? = nil
    private let fileManager = LocalFileManager.instance
    
    private var cancellables = Set<AnyCancellable>()
    private let coin : CoinModel
    private let imageName : String
    
    init(coin : CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getImage()
    }
    
    
    private func getImage(){
        if let savedImage = fileManager.getImage(imageName: imageName , folderName: "Coin_Images"){
            image = savedImage
        }else{
            downloadCoinImage()

        }
    }
    
    func downloadCoinImage(){
        guard let url = URL(string: coin.image) else {return}
        NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink { completion in
                NetworkingManager.handleCompletion(completion: completion)
            } receiveValue: { [weak self] returnedImage in
                
                guard let self = self  , let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: "Coin_Images")
            }
            .store(in: &cancellables)

    }
}

//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 11/04/2023.
//

import Foundation
import Combine
class NetworkingManager {
    static func download(url : URL) ->  AnyPublisher<Data,APIError> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse ,
                        response.statusCode >= 200 && response.statusCode < 300 else {
                    throw  APIError.unknown
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .mapError { error in
                APIError.decodingError
            }
            .eraseToAnyPublisher()
    }
    
    
    static func handleCompletion(completion : Subscribers.Completion<Error>){
        switch completion {
        case .finished :
        print("success")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

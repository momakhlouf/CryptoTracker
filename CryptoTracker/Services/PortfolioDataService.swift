//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 06/05/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    @Published var saveEntities : [PortfolioEntity] = []
    private let container : NSPersistentContainer
    private let containerName = "portfolioContainer"
    private let entityName = "PortfolioEntity"
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _ , error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        getPortfolio()
    }
    
    
    //MARK: PUBLIC FUNCS
    func updatePortfolio(coin : CoinModel , amount : Double){
        if let entity = saveEntities.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                updateCoin(entity: entity, amount: amount)
            }else{
                deleteCoin(entity: entity)
            }
        }else{
            addCoin(coin: coin, amount: amount)
        }
    }
    
    //MARK: PRIVATE FUNCS
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            saveEntities = try container.viewContext.fetch(request)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    private func addCoin(coin : CoinModel , amount : Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
       applyChanges()
    }
    
    private func updateCoin(entity: PortfolioEntity , amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func deleteCoin(entity : PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    

    
    private func save(){
        do{
            try container.viewContext.save()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
}

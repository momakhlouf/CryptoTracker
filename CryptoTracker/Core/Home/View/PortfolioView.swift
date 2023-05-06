//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 04/05/2023.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin : CoinModel? = nil
    @State private var coinAmount : String = ""
    @State private var showCheckMark : Bool = false

    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    coinListView
                    if selectedCoin != nil {
                       portfolioAmount
                    }
               }
           }
            .navigationTitle("Edit Profile")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                  CancelButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                  saveButtonView
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                  removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var coinListView : some View {
        
        ScrollView(.horizontal , showsIndicators: false){
            LazyHStack {
                ForEach(vm.coins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear , lineWidth: 1)
                        )}
            }
            .padding(.vertical , 4)
            .padding(.leading)
            
        }
    }
    
    private var portfolioAmount : some View {
        VStack{
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.currencyFormat() ?? "")
            }
            Divider()
            HStack{
                Text("Amount holding:")
                Spacer()
                TextField("EX:2.7", text: $coinAmount)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }

            Divider()
            HStack{
            Text("Current value:")
            Spacer()
            Text(getCurrentValue().currencyFormat())
            }
        }
        .padding()
        .animation(.none)
        .font(.headline)
    }
    
    private var saveButtonView : some View {
        ZStack{
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())

            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(coinAmount) ? 1.0 : 0.0 )

            
        }
    }
    private func getCurrentValue() -> Double{
        if let amount = Double(coinAmount){
            return amount * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed(){
        
        guard let coin = selectedCoin else {return}
        // save to portfolio
        
        //show checkMark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            showCheckMark = false
        }
        
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
    
}

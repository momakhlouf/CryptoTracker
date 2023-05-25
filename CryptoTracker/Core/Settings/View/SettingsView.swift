//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 25/05/2023.
//

import SwiftUI

struct SettingsView: View {
    
 
    var body: some View {
        NavigationStack{
            List{
              aboutAppSection
                                
                  contactsSection
                coinGeckoSection

              
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    
    
    private var aboutAppSection : some View {
        Section(header: Text("About")){
                HStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 100 , height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("this app helps users monitor and manage their cryptocurrency investments.It provides real-time updates on prices, market trends, and provides users a personalized portfolios.")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.secondaryText)
                }
        }
    }
    private var contactsSection : some View {
        Section(header: Text("Contacts")){
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 70 , height: 70)
                    VStack(alignment: .leading , spacing: 15){
                        Text("Mohamed Makhlouf")
                        Text("iOS Developer")
                    }
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                }
            }
            HStack{
                Image("linkedin")
                    .resizable()
                    .frame(width: 30 , height: 30)
                Link("Linkedin", destination: Contacts.linkedinURL)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            HStack{
                Image("gmail")
                    .resizable()
                    .frame(width: 30 , height: 30)
                
                Link( "Contact me via email" ,destination: URL(string: Contacts.email)!)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            HStack{
                Image(systemName: "phone.circle.fill")
                    .resizable()
                    .frame(width: 30 , height: 30)
                    .foregroundColor(.theme.accent)
                
                Link( "Call me " ,destination: URL(string: Contacts.phone)!)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
    
    
    private var coinGeckoSection : some View {
        Section(header: Text("Coingecko")){
            VStack{
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Text("The cryptocurrency data that is used in this app comes from CoinGecko.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.secondaryText)
            }
            Link( "Visit CoinGecko" ,destination: Contacts.coinGeckoURL!)
                .font(.headline)
                .accentColor(.blue)
        }
    }
}

enum Contacts {
    static let linkedinURL = URL(string: "https://www.linkedin.com/in/momakhlouf/")!
    static let phone = "tel:+201557525122"
    static let email = "mailto:momakhlouf.a@gmail.com"
    static let coinGeckoURL = URL(string: "https://www.coingecko.com")
}

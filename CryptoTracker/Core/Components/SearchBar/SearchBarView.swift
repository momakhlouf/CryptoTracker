//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 12/04/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                  Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name ...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
            
            Button {
                searchText = ""
                UIApplication.shared.endEditing()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    //.padding()
                    .foregroundColor(Color.theme.secondaryText)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
            }
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}

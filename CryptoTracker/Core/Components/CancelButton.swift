//
//  CancelButton.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 04/05/2023.
//

import SwiftUI

struct CancelButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button{
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        CancelButton()
    }
}

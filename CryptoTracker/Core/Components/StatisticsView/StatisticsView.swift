//
//  StatisticsView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 12/04/2023.
//

import SwiftUI

struct StatisticsView: View {
    @State var stat : StatisticsModel
    var body: some View {
        VStack(alignment: .leading , spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack{
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: stat.percentage ?? 0 >= 0 ? 0 : 180))
                Text(stat.percentage?.percentStringFormat() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(stat.percentage ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentage == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stat: dev.state1 )
    }
}

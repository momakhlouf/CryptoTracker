//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Mohamed Makhlouf Ahmed on 24/05/2023.
//

import SwiftUI

struct ChartView: View {
    
    private let data : [Double]
    private let maxY : Double
    private let minY : Double
    private let chartColor : Color
    @State private var lineTrimTo : CGFloat = 0
    
    init(coin : CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = data.max() ?? 0
        self.minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        chartColor = priceChange > 0 ? .theme.green : .theme.red

    }
    
    var body: some View {
      chartView
            .frame(height: 200)
            .background(chartBackGround)
            .overlay(yAxisValues.padding(.horizontal , 4) ,alignment: .leading)
            .font(.caption)
            .foregroundColor(.theme.secondaryText)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                    withAnimation(.linear(duration: 2)) {
                        lineTrimTo = 1
                    }
                }
            }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    private var chartView : some View {
        GeometryReader { geo in
            Path{ path in
                for index in data.indices {
                    
                    let xPosition = geo.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat(data[index] - minY) / yAxis) * geo.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0 , to: lineTrimTo)
            .stroke( chartColor ,style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: chartColor, radius: 10, x: 0.0, y: 20)
            .shadow(color: chartColor.opacity(0.5), radius: 10, x: 0.0, y: 20)

        }
    }
    
    private var chartBackGround : some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var yAxisValues : some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
           
            Text( ((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
}

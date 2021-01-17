//
//  DateButton.swift
//  POSdan
//
//  Created by Dannover Arroyave on 5/01/21.
//

import SwiftUI

struct DateButton: View {
    
    var title : String
    @ObservedObject var gastoData : GastoViewModel
    
    var body: some View {
        
        Button(action: {
            
            gastoData.updateDate(value: title)
            
        }, label: {
            
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(gastoData.checkDate() == title ? .white : .gray)
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .background(
                    
                    gastoData.checkDate() == title ?
                        LinearGradient(gradient: .init(colors: [
                            Color(red: 0.985, green: 0.585, blue: 0.381, opacity: 1),
                            Color(red: 0.966, green: 0.304, blue: 0.449, opacity: 1)
                        ]), startPoint: .leading, endPoint: .trailing)
                        
                        : LinearGradient(gradient: .init(colors: [Color.white]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(6)
            
        })
    }
}

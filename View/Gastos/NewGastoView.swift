//
//  NewGastoView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 5/01/21.
//

import SwiftUI

struct NewGastoView: View {
    
    @ObservedObject var gastoData : GastoViewModel
    
    var body: some View {
        
        VStack {
            
            HStack{
                
                Text("\(gastoData.updateItem == nil ? "Add New" : "Update") Gasto")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            TextField("nombre", text: $gastoData.name)
                .textContentType(.name)
                .padding()
            
            /*
            TextField("amount", text: $gastoData.amount)
                .keyboardType(.decimalPad)
                .padding()
            */
            
            TextEditor(text: $gastoData.note)
                .padding()
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                
                Text("Date")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
            }
            .padding()
            
            HStack(spacing: 10){
                
                DateButton(title: "Today", gastoData: gastoData)
                
                DateButton(title: "Tomorrow", gastoData: gastoData)
                
                // Date Picker...
                
                DatePicker("", selection: $gastoData.date, displayedComponents: .date)
                    .labelsHidden()
                
            }
            .padding()
            
            Button(action: {
                
                gastoData.addGasto(name: gastoData.name, note: gastoData.note, date: gastoData.date, amount:  0)
                
            }, label: {
                
                Label(
                    title: { Text(gastoData.updateItem == nil ? "Add Gasto" : "Update")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                        
                        LinearGradient(gradient: .init(colors: [
                            Color(red: 0.985, green: 0.585, blue: 0.381, opacity: 1),
                            Color(red: 0.966, green: 0.304, blue: 0.449, opacity: 1)
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
                
            })
            .padding()
            // disabling button when no data...
            .disabled((gastoData.note == "" && gastoData.name == "") ? true : false)
            .opacity((gastoData.note == "" && gastoData.name == "") ? 0.5 : 1)
            
        }.background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}

//
//  GastoView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI

struct GastoView: View {
    
    @State var txt = ""
    
    @StateObject var gastoData = GastoViewModel()
    
    var body: some View {
        
        VStack {
            
            if gastoData.gastos.isEmpty {
                
                Spacer(minLength: 0)
                
                if gastoData.noData {
                    
                    Text("No Gastos !!!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                }
                else {
                    
                    ProgressView()
                }
                
                Spacer(minLength: 0)
                
            }
            else {
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    LazyVStack(alignment: .leading,spacing: 20){
                        
                        ForEach(gastoData.gastos){gasto in
                            
                            VStack(alignment: .leading, spacing: 5, content: {
                                
                                Text(gasto.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text(gasto.date,style: .date)
                                    .fontWeight(.bold)
                                
                                Text(String(gasto.amount))
                                    .fontWeight(.bold)
                                
                            })
                            .foregroundColor(.black)
                            .contextMenu{
                                
                                Button(action: {
                                    
                                    gastoData.EditItem(item: gasto)
                                    
                                }, label: {
                                    
                                    Text("Edit")
                                    
                                })
                                
                                Button(action: {
                                    
                                }, label: {
                                    
                                    Text("Delete")
                                    
                                })
                            }
                        }
                    }
                    .padding()
                })
                
            }
        }
        .navigationTitle("Gastos")
        .navigationBarItems(trailing: Button(action: {
            
            gastoData.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .sheet(isPresented: $gastoData.isNewData, content: {
            
            NewGastoView(gastoData: gastoData)
            
        })
    }
}

struct GastoView_Previews: PreviewProvider {
    static var previews: some View {
        GastoView()
    }
}

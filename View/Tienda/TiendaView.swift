//
//  TiendaView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 31/12/20.
//

import SwiftUI

struct TiendaView: View {
    
    @State var txt = ""
    
    @StateObject var viewModel = ShopViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.shops.isEmpty {
                
                Spacer()
                
                Text("No Data !!!")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                
                Spacer()
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    LazyVStack(alignment: .leading,spacing: 20){
                        
                        ForEach(viewModel.shops){ shop in
                            
                            TiendaRowView(shop: shop, viewModel: viewModel)
                            
                        }
                        
                    }
                    .padding()
                })
            }
        }
        .navigationTitle("Tiendas")
        .navigationBarItems(trailing: Button(action: {
            
            viewModel.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .fullScreenCover(isPresented: $viewModel.isNewData, content: {
            
            TiendaNewView(viewModel: viewModel)
            
        })
        
    }
}


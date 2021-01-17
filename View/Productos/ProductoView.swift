//
//  ProductoView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI

struct ProductoView: View {
    
    @StateObject var viewModel = ProductoViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.productos.isEmpty {
                
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
                        
                        ForEach(viewModel.productos){ producto in
                            
                            ProductoRowView(producto: producto, viewModel: viewModel)
                            
                        }
                        
                    }
                    .padding()
                })
            }
        }
        .navigationTitle("Productos")
        .navigationBarItems(trailing: Button(action: {
            
            viewModel.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .fullScreenCover(isPresented: $viewModel.isNewData, content: {
            
            ProductoNewView(viewModel: viewModel)
            
        })
        
    }
}

//
//  ProveedorView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//


import SwiftUI

struct ProveedorView: View {
    
    @StateObject var viewModel = ProveedorViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.proveedores.isEmpty {
                
                Spacer()
                
                Text("No Data !!!")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                
                Spacer()
            }
            else {
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    LazyVStack(alignment: .leading,spacing: 20){
                        
                        ForEach(viewModel.proveedores){ proveedor in
                            
                            ProveedorRowView(proveedor: proveedor, viewModel: viewModel)
                            
                        }
                        
                    }
                    .padding()
                })
            }
        }
        .navigationTitle("Proveedores")
        .navigationBarItems(trailing: Button(action: {
            
            viewModel.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .fullScreenCover(isPresented: $viewModel.isNewData, content: {
            
            ProveedorNewView(viewModel: viewModel)
            
        })
        
    }
}

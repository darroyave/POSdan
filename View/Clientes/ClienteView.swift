//
//  ClienteView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 31/12/20.
//

import SwiftUI

struct ClienteView: View {
    
    @StateObject var viewModel = ClienteViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.clientes.isEmpty {
                
                Spacer()
                
                Text("No Data !!!")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                
                Spacer()
                
            }
            else {
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    LazyVStack(alignment: .leading,spacing: 20) {
                        
                        ForEach(viewModel.clientes){ cliente in
                            
                            ClienteRowView(cliente: cliente, viewModel: viewModel)
                            
                        }
                        
                    }
                    .padding()
                })
                
            }
            
        }
        .navigationTitle("Clientes")
        .navigationBarItems(trailing: Button(action: {
            
            viewModel.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .fullScreenCover(isPresented: $viewModel.isNewData, content: {
            
            ClienteNewView(viewModel: viewModel)
            
        })
        
    }
}

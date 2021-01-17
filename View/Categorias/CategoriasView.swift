//
//  CategoriasView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 31/12/20.
//

import SwiftUI

struct CategoriasView: View {
    
    @StateObject var viewModel = CategoriaViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.categorias.isEmpty {
                
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
                        
                        ForEach(viewModel.categorias){ categoria in
                            
                            CategoriaRowView(categoria: categoria, viewModel: viewModel)
                            
                        }
                        
                    }
                    .padding()
                })
            }
        }
        .navigationTitle("Categorias")
        .navigationBarItems(trailing: Button(action: {
            
            viewModel.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .fullScreenCover(isPresented: $viewModel.isNewData, content: {
            
            CategoriaNewView(viewModel: viewModel)
            
        })
        
    }
}

//
//  CategoriaCellView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI

struct CategoriaRowView: View {
    
    var categoria: CategoriaModel
    @ObservedObject var viewModel: CategoriaViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5, content: {
            
            HStack(spacing: 10) {
                
                Text(categoria.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Button(action: {
                        
                        viewModel.EditItem(item: categoria)
                        
                    }) {
                        
                        Text("Edit")
                    }
                    
                    Button(action: {
                        
                        viewModel.DeleteItem(id: categoria.id ?? "")
                        
                    }) {
                        
                        Text("Delete")
                    }
                    
                }, label: {
                    
                    Image("menu")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.black)
                })
            }
            
        })
        .foregroundColor(.black)
    }
}

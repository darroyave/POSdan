//
//  ProductoRowView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 8/01/21.
//

import SwiftUI

struct ProductoRowView: View {
    
    var producto: ProductoModel
    @ObservedObject var viewModel: ProductoViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5, content: {
            
            HStack(spacing: 10) {
                
                Text(producto.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Button(action: {
                        
                        viewModel.EditItem(item: producto)
                        
                    }) {
                        
                        Text("Edit")
                    }
                    
                    Button(action: {
                        
                        viewModel.DeleteItem(id: producto.id ?? "")
                        
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
            
            HStack{
                
                Text("Code: \(producto.code)")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text("Sell Price: \(String(producto.sell_price))")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
        })
        .foregroundColor(.black)
    }
}

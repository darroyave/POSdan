//
//  ClienteCellView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 3/01/21.
//

import SwiftUI

struct ClienteRowView: View {
    
    var cliente: ClienteModel
    @ObservedObject var viewModel: ClienteViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5, content: {
            
            HStack(spacing: 10) {
                
                Text(cliente.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Button(action: {
                        
                        viewModel.EditItem(item: cliente)
                        
                    }) {
                        
                        Text("Edit")
                    }
                    
                    Button(action: {
                        
                        viewModel.DeleteItem(id: cliente.id ?? "")
                        
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
                
                Text(cliente.email)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text(cliente.phone)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text(cliente.address)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
        })
        .foregroundColor(.black)
    }
}

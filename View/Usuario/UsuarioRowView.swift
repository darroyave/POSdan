//
//  UsuarioCellView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI

struct UsuarioRowView: View {
    
    var usuario: UsuarioModel
    @ObservedObject var viewModel: UsuarioViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5, content: {
            
            HStack(spacing: 10) {
                
                Text(usuario.email)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Button(action: {
                        
                        viewModel.EditItem(item: usuario)
                        
                    }) {
                        
                        Text("Edit")
                    }
                    
                    Button(action: {
                        
                        viewModel.DeleteItem(id: usuario.id ?? "")
                        
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
                
                Text(usuario.phone)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text(usuario.tipo)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
        })
        .foregroundColor(.black)
    }
}

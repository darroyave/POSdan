//
//  ProveedorRowView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 6/01/21.
//

import SwiftUI

struct ProveedorRowView: View {
    
    var proveedor: ProveedorModel
    @ObservedObject var viewModel: ProveedorViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5, content: {
            
            HStack(spacing: 10) {
                
                Text(proveedor.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Button(action: {
                        
                        viewModel.EditItem(item: proveedor)
                        
                    }) {
                        
                        Text("Edit")
                    }
                    
                    Button(action: {
                        
                        viewModel.DeleteItem(id: proveedor.id ?? "")
                        
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
                
                Text(proveedor.email)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text(proveedor.phone)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text(proveedor.contactperson)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text(proveedor.address)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
        })
        .foregroundColor(.black)
    }
}

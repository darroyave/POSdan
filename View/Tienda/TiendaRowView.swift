//
//  TiendaCellView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import SwiftUI

struct TiendaRowView: View {
    
    var shop: ShopModel
    @ObservedObject var viewModel: ShopViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5, content: {
            
            HStack(spacing: 10) {
                
                Text(shop.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Button(action: {
                        
                        viewModel.EditItem(item: shop)
                        
                    }) {
                        
                        Text("Edit")
                    }
                    
                    Button(action: {
                        
                        viewModel.DeleteItem(id: shop.id ?? "")
                        
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
                
                Text("Contact: \(shop.contact)")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text(shop.email)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
            HStack{
                
                Text("Tax: \(String(shop.tax))")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding(.top, 5)
            
        })
        .foregroundColor(.black)
    }
}

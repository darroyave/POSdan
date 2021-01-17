//
//  FormaPagoCellView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import SwiftUI

struct FormaPagoRowView: View {
    
    var formapago: FormaPagoModel
    @ObservedObject var viewModel: FormaPagoViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5, content: {
            
            HStack(spacing: 10) {
                
                Text(formapago.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Button(action: {
                        
                        viewModel.EditItem(item: formapago)
                        
                    }) {
                        
                        Text("Edit")
                    }
                    
                    Button(action: {
                        
                        viewModel.DeleteItem(id: formapago.id ?? "")
                        
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

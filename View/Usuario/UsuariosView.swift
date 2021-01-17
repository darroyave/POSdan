//
//  UsuariosView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 31/12/20.
//

import SwiftUI

struct UsuariosView: View {
    
    @StateObject var viewModel = UsuarioViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.usuarios.isEmpty {
                
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
                        
                        ForEach(viewModel.usuarios){ usuario in
                            
                            UsuarioRowView(usuario: usuario, viewModel: viewModel)
                            
                        }
                        
                    }
                    .padding()
                })
            }
        }
        .navigationTitle("Usuarios")
        .navigationBarItems(trailing: Button(action: {
            
            viewModel.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .fullScreenCover(isPresented: $viewModel.isNewData, content: {
            
            UsuarioNewView(viewModel: viewModel)
            
        })
        
    }
}

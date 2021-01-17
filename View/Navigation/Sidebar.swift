//
//  Sidebar.swift
//  POSdan
//
//  Created by Dannover Arroyave on 16/01/21.
//

import SwiftUI

struct Sidebar: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            
            content
                .navigationTitle("POSDan")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                         Image(systemName: "person.crop.circle")
                    }
                }
            
            HomeView()
        }
    }
    
    var content: some View {
        
        List {
            
            NavigationLink(destination: HomeView()) {
                Label("Home", systemImage: "house.circle")
            }
            
            NavigationLink(destination: TiendaView()) {
                Label("Tienda", systemImage: "bag")
            }
            
            NavigationLink(destination: UsuariosView()) {
                Label("Usuarios", systemImage: "person.2")
            }
            
            NavigationLink(destination: CategoriasView()) {
                Label("Categorias", systemImage: "doc.plaintext.fill")
            }
            
            NavigationLink(destination: FormaPagoView()) {
                Label("Formas de Pago", systemImage: "creditcard")
            }
            
            Divider()
            
            Button {
                
                _ = self.viewModel.signOut()
                
            } label: {
                
                Label("Salida Segura", systemImage: "chevron.down.circle")
                
            }

        }
        .listStyle(SidebarListStyle())
        
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}

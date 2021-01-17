//
//  MainPage.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 260), spacing: 16)],
                    spacing: 16
                ) {
                    ForEach(menus) { item in
                        
                        NavigationLink(destination: {
                            VStack {
                                if item.id == 1 {
                                    ClienteView()
                                } else if item.id == 2 {
                                    ProveedorView()
                                } else if item.id == 3 {
                                    ProductoView()
                                } else if item.id == 4 {
                                    GastoView()
                                } else if item.id == 5 {
                                    POSView()
                                } else if item.id == 6 {
                                    OrdenView()
                                } else {
                                    ReporteView()
                                }
                            }
                        }()) {
                            
                            HomeItem(menu: item)
                                .frame(height: 200)
                            
                        }
                        
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
            }
            
        }
        .navigationTitle("Home")
    }
    
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

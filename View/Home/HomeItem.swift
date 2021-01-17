//
//  HomeItem.swift
//  POSdan
//
//  Created by Dannover Arroyave on 16/01/21.
//

import SwiftUI

struct HomeItem: View {
    
    var menu: MenuItem = menus[0]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4.0) {
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                Image(menu.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
            }
            
            Text(menu.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
        }
        .padding(.all)
        .background(menu.color)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: menu.color.opacity(0.3), radius: 20, x: 0, y: 10)
        
    }
    
}

struct HomeItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeItem()
    }
}

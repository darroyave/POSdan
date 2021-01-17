//
//  TitleView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import SwiftUI

struct TitleView: View {
    var Title: String
    
    var body: some View {
        
        HStack{
            
            Text(Title)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Spacer(minLength: 0)
        }
        .padding()
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.white)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(Title: "WELCOME")
    }
}

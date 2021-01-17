//
//  ContentView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 29/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        Group {
            
            if (viewModel.user != nil && viewModel.isEmailverified) {

                Sidebar()
                
            } else {
                
                WelcomeView()
                    .environmentObject(self.viewModel)
                
            }
            
        }
        
    }
    
}

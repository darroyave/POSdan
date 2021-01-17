//
//  POSdanApp.swift
//  POSdan
//
//  Created by Dannover Arroyave on 29/12/20.
//

import SwiftUI
import Firebase

@main
struct POSdanApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel())
        }
    }
}

// http://www.dar-elweb.com/demos/zarest/products

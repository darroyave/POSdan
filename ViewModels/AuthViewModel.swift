//
//  FirebaseAuth.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import Foundation

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var isEmailverified: Bool = false
    
    var isSignIn = false
    
    @Published var userName: String = ""
    @Published var deviceActive: Bool = false
    @Published var userWarnInfo: String = ""
   
    init() {
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if let user = user {
                
                self.user = User(
                    
                    uid: user.uid,
                    email: user.email,
                    emailVerified: user.isEmailVerified,
                    userName: user.displayName,
                    userAlertInfo: ""
                    
                )
                
                self.userName = user.displayName ?? "Not Set"
                
                self.isEmailverified = user.isEmailVerified
                
            }
                
            else {
                
                self.isSignIn = true
                self.user = nil
              
            }
            
        }
        
    }

    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        
    }
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.user = nil
            return true
        } catch {
            return false
        }
    }
    
}

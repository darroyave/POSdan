//
//  WelcomeView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var signUpIsPresent: Bool = false
    @State var signInIsPresent: Bool = false
    @State private var showButtons = true
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            if viewModel.user == nil || !viewModel.isEmailverified {
                
                VStack(spacing:20) {
                    
                    if showButtons {
                        
                        VStack(spacing: 20){
                            
                            Button(action: {
                                self.signInIsPresent = true
                                
                            }){
                                
                                Text("SIGN IN").padding(10)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                
                            }
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .cornerRadius(0)
                            .overlay(RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                                        .foregroundColor(Color.init(.systemYellow)))
                            .sheet(isPresented: $signInIsPresent) {
                                
                                SignInView(onDismiss:{
                                    
                                    print("Dismissed")
                                    
                                }).environmentObject(self.viewModel)
                                
                            }
                            
                            Button(action: {self.signUpIsPresent = true}){
                                Text("SIGN UP").padding(10)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                
                            }
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .cornerRadius(0)
                            .overlay(RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                                        .foregroundColor(Color.init(.systemYellow))).sheet(isPresented: self.$signUpIsPresent){
                                            
                                            SignUpView().environmentObject(self.viewModel)
                                            
                                        }
                            
                            
                        }.animation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 2))
                        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                        
                    }
                    
                }
                .padding(10)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
            } else {
                
                ActivityIndicator(shouldAnimate: .constant(true))
                
            }
            
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

//
//  FormaPagoView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 31/12/20.
//

import SwiftUI

struct FormaPagoView: View {
    
    @StateObject var viewModel = FormaPagoViewModel()
    
    var body: some View {
        
        VStack {
            
            if viewModel.formas.isEmpty {
                
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
                        
                        ForEach(viewModel.formas){ formapago in
                            
                            FormaPagoRowView(formapago: formapago, viewModel: viewModel)
                            
                        }
                        
                    }
                    .padding()
                })
            }
        }
        .navigationTitle("Formas de Pago")
        .navigationBarItems(trailing: Button(action: {
            
            viewModel.isNewData.toggle()
            
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .fullScreenCover(isPresented: $viewModel.isNewData, content: {
            
            FormaPagoNewView(viewModel: viewModel)
            
        })
        
    }
}

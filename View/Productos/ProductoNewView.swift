//
//  ProductoNewView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 8/01/21.
//

import SwiftUI

struct ProductoNewView: View {
    
    @ObservedObject var viewModel : ProductoViewModel
    
    @Environment(\.presentationMode) var present
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Button(action: {
                    
                    viewModel.cancel()
                    
                    present.wrappedValue.dismiss()
                    
                }) {
                    
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(Color("blue"))
                }
                
                Spacer(minLength: 0)
                
                Text("\(viewModel.id == "" ? "Add New" : "Update") Producto")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            .padding()
            
            TextField("name", text: $viewModel.name)
                .font(.title2)
                .padding()
            
            TextField("code", text: $viewModel.code)
                .font(.title2)
                .padding()
            
            TextField("sell_price", text: $viewModel.sell_price_str.value)
                .font(.title2)
                .keyboardType(.decimalPad)
                .padding()
            
            TextEditor(text: $viewModel.description)
                .font(.title2)
                .padding()
            
            // Add Button....
            
            Button(action: {
                
                viewModel.saveData()
                
            }, label: {
                
                Label(
                    
                    title: { Text(viewModel.id == "" ? "Add Now" : "Update")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: {
                        
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                        
                        LinearGradient(gradient: .init(colors: [Color("Gradiente1"),Color("Gradiente2")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
                
            })
            .padding()
            // disabling button when no data...
            .disabled((viewModel.name == "" || viewModel.code == "") ? true : false)
            .opacity((viewModel.name == "" || viewModel.code == "") ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
        
    }
}

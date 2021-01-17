//
//  NewProveedorView.swift
//  POSdan
//
//  Created by Dannover Arroyave on 6/01/21.
//

import SwiftUI

struct ProveedorNewView: View {
    
    @ObservedObject var viewModel : ProveedorViewModel
    
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
                
                Text("\(viewModel.id == "" ? "Add New" : "Update") Proveedor")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            .padding()
            
            TextField("name", text: $viewModel.name)
                .font(.title2)
                .padding()
            
            TextField("email", text: $viewModel.email)
                .font(.title2)
                .padding()
            
            TextField("phone", text: $viewModel.phone)
                .font(.title2)
                .keyboardType(.decimalPad)
                .padding()
            
            TextField("contactperson", text: $viewModel.contactperson)
                .font(.title2)
                .keyboardType(.decimalPad)
                .padding()
            
            TextEditor(text: $viewModel.address)
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
            .disabled((viewModel.name == "" || viewModel.email == "") ? true : false)
            .opacity((viewModel.name == "" || viewModel.email == "") ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
        
    }
}

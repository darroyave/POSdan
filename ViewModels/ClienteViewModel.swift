//
//  CustomersViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 3/01/21.
//

import Foundation
import Firebase

import SwiftUI
import Firebase

class ClienteViewModel : ObservableObject {
    
    @Published var isNewData = false
    
    @Published var clientes: [ClienteModel] = []
    
    @Published var noData = false
    
    @Published var id = ""
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var address = ""
    
    init() {
        
        fetchData()
        
    }
    
    func fetchData() {
        
        COLLECTION_CUSTOMER.order(by: "name").addSnapshotListener({ (snap, err) in
            
            if err != nil {
                print(err!.localizedDescription)
                self.noData = true
                return
            }
            
            guard let data = snap else {
                self.noData = true
                return
            }
            
            if data.documentChanges.isEmpty{
                
                self.noData = true
                return
                
            }
            
            data.documentChanges.forEach { (doc) in
                
                if doc.type == .added {
                    
                    let prod = try! doc.document.data(as: ClienteModel.self)!
                    
                    DispatchQueue.main.async {
                        self.clientes.append(prod)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.clientes.removeAll { (prod) -> Bool in
                        return prod.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.clientes.firstIndex { (prod) -> Bool in
                        return prod.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                        self.clientes[index].name = doc.document.data()["name"] as! String
                        self.clientes[index].phone = doc.document.data()["phone"] as! String
                        self.clientes[index].email = doc.document.data()["email"] as! String
                        self.clientes[index].address = doc.document.data()["address"] as! String
                        
                    }
                    
                }
            }
        })
    }
    
    func saveData() {
        
        // Updating Item.....
        
        if id != "" {
            
            COLLECTION_CUSTOMER.document(id).updateData([
                
                "name": self.name,
                "phone": self.phone,
                "email": self.email,
                "address": self.address
                
            ]) { (err) in
                
                self.id = ""
                self.isNewData.toggle()
                
                self.name = ""
                self.phone = ""
                self.email = ""
                self.address = ""
                
            }
            
            return
        }
        
        let item = ClienteModel(address: self.address, email: self.email, name: self.name, phone: self.phone)
        
        let _ = try! COLLECTION_CUSTOMER.addDocument(from: item) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.isNewData.toggle()
            
            self.name = ""
            self.phone = ""
            self.email = ""
            self.address = ""
            
        }
        
    }
    
    func EditItem(item: ClienteModel){
        
        self.id = item.id!
        self.name = item.name
        self.email = item.email
        self.address = item.address
        self.phone = item.phone
        
        self.isNewData.toggle()
    }
    
    func DeleteItem(id: String){
        
        COLLECTION_CUSTOMER.document(id).delete { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func cancel() {
        
        self.id = ""
        self.name = ""
        self.phone = ""
        self.address = ""
        self.email = ""
        
    }
}

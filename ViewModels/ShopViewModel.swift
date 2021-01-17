//
//  ShopViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//


import SwiftUI
import Firebase

class ShopViewModel : ObservableObject {
    
    @Published var isNewData = false
    
    @Published var shops: [ShopModel] = []
    
    @Published var noData = false
    
    @Published var id = ""
    @Published var name = ""
    @Published var email = ""
    @Published var contact = ""
    @Published var address = ""
    @Published var moneda = ""
    @Published var tax_str = NumbersOnly()
    
    init() {
        
        fetchData()
        
    }
    
    func fetchData() {
        
        COLLECTION_SHOP.order(by: "name").addSnapshotListener({ (snap, err) in
            
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
                    
                    let tienda = try! doc.document.data(as: ShopModel.self)!
                    
                    DispatchQueue.main.async {
                        self.shops.append(tienda)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.shops.removeAll { (tienda) -> Bool in
                        return tienda.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.shops.firstIndex { (tienda) -> Bool in
                        return tienda.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                        self.shops[index].name = doc.document.data()["name"] as! String
                        self.shops[index].email = doc.document.data()["email"] as! String
                        self.shops[index].contact = doc.document.data()["contact"] as! String
                        self.shops[index].address = doc.document.data()["address"] as! String
                        self.shops[index].moneda = doc.document.data()["moneda"] as! String
                        self.shops[index].tax = doc.document.data()["tax"] as! Int
                        
                    }
                    
                }
            }
        })
    }
    
    func saveData() {
        
        // Updating Item.....
        
        if id != "" {
            
            COLLECTION_SHOP.document(id).updateData([
                
                "name": self.name,
                "email": self.email,
                "contact": self.contact,
                "address": self.address,
                "moneda": self.moneda,
                "tax": Int(self.tax_str.value) ?? 0
                
            ]) { (err) in
                
                self.id = ""
                self.isNewData.toggle()
                
                self.name = ""
                self.email = ""
                self.contact = ""
                self.address = ""
                self.moneda = ""
                self.tax_str.value = "0"
                
            }
            
            return
        }
        
        let tienda = ShopModel(address: self.address, contact: self.contact, moneda: self.moneda, email: self.email, name: self.name, tax: Int(self.tax_str.value) ?? 0)
        
        let _ = try! COLLECTION_SHOP.addDocument(from: tienda) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.isNewData.toggle()
            
            self.name = ""
            self.email = ""
            self.contact = ""
            self.address = ""
            self.moneda = ""
            self.tax_str.value = "0"
            
        }
        
    }
    
    func EditItem(item: ShopModel){
        
        self.id = item.id!
        self.name = item.name
        self.contact = item.contact
        self.address = item.address
        self.moneda = item.moneda
        self.tax_str.value = String(item.tax)
        
        self.isNewData.toggle()
    }
    
    func DeleteItem(id: String){
        
        COLLECTION_SHOP.document(id).delete { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func cancel() {
        
        self.id = ""
        self.name = ""
        self.email = ""
        self.contact = ""
        self.address = ""
        self.moneda = ""
        self.tax_str.value = "0"
        
    }
}

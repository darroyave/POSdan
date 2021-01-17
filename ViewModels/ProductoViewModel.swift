//
//  ProductoViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 8/01/21.
//

import SwiftUI
import Firebase

class ProductoViewModel : ObservableObject {
    
    @Published var isNewData = false
    
    @Published var productos: [ProductoModel] = []
    
    @Published var noData = false
    
    @Published var id = ""
    @Published var name = ""
    @Published var code = ""
    @Published var description = ""
    @Published var sell_price_str = NumbersOnly()
    
    init() {
        
        fetchData()
        
    }
    
    func fetchData() {
        
        COLLECTION_PRODUCTS.order(by: "name").addSnapshotListener({ (snap, err) in
            
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
                    
                    let prod = try! doc.document.data(as: ProductoModel.self)!
                    
                    DispatchQueue.main.async {
                        self.productos.append(prod)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.productos.removeAll { (prod) -> Bool in
                        return prod.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.productos.firstIndex { (prod) -> Bool in
                        return prod.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                        self.productos[index].name = doc.document.data()["name"] as! String
                        self.productos[index].description = doc.document.data()["description"] as! String
                        self.productos[index].code = doc.document.data()["code"] as! String
                        self.productos[index].sell_price = doc.document.data()["sell_price"] as! Int
                        
                    }
                    
                }
            }
        })
    }
    
    func saveData() {
        
        // Updating Item.....
        
        if id != "" {
            
            COLLECTION_PRODUCTS.document(id).updateData([
                
                "name": self.name,
                "description": self.description,
                "code": self.code,
                "sell_price": Int(self.sell_price_str.value) ?? 0
                
            ]) { (err) in
                
                self.id = ""
                self.isNewData.toggle()
                
                self.name = ""
                self.code = ""
                self.description = ""
                self.sell_price_str.value = "0"
                
            }
            
            return
        }
        
        let prod = ProductoModel(name: name, description: description, code: code, sell_price: Int(sell_price_str.value) ?? 0)
        
        let _ = try! COLLECTION_PRODUCTS.addDocument(from: prod) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.isNewData.toggle()
            
            self.name = ""
            self.code = ""
            self.description = ""
            self.sell_price_str.value = "0"
            
        }
        
    }
    
    func EditItem(item: ProductoModel){
        
        self.id = item.id!
        self.name = item.name
        self.code = item.code
        self.description = item.description
        self.sell_price_str.value = String(item.sell_price)
        
        self.isNewData.toggle()
    }
    
    func DeleteItem(id: String){
        
        COLLECTION_PRODUCTS.document(id).delete { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func cancel() {
        
        self.id = ""
        self.name = ""
        self.code = ""
        self.description = ""
        self.sell_price_str.value = "0"
        
    }
}

//
//  FormaPagoViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import SwiftUI
import Firebase

class FormaPagoViewModel : ObservableObject {
    
    @Published var isNewData = false
    
    @Published var formas: [FormaPagoModel] = []
    
    @Published var noData = false
    
    @Published var id = ""
    @Published var name = ""
    
    init() {
        
        fetchData()
        
    }
    
    func fetchData() {
        
        COLLECTION_FORMAPAGO.order(by: "name").addSnapshotListener({ (snap, err) in
            
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
                    
                    let cat = try! doc.document.data(as: FormaPagoModel.self)!
                    
                    DispatchQueue.main.async {
                        self.formas.append(cat)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.formas.removeAll { (cat) -> Bool in
                        return cat.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.formas.firstIndex { (cat) -> Bool in
                        return cat.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                        self.formas[index].name = doc.document.data()["name"] as! String
                        
                    }
                    
                }
            }
        })
    }
    
    func saveData() {
        
        // Updating Item.....
        
        if id != "" {
            
            COLLECTION_FORMAPAGO.document(id).updateData([
                
                "name": self.name
                
            ]) { (err) in
                
                self.id = ""
                
                self.isNewData.toggle()
                
                self.name = ""
                
            }
            
            return
        }
        
        let cat = CategoriaModel(name: name)
        
        let _ = try! COLLECTION_FORMAPAGO.addDocument(from: cat) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.isNewData.toggle()
            
            self.name = ""
            
        }
        
    }
    
    func EditItem(item: FormaPagoModel){
        
        self.id = item.id!
        self.name = item.name
        
        self.isNewData.toggle()
    }
    
    func DeleteItem(id: String){
        
        COLLECTION_FORMAPAGO.document(id).delete { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func cancel() {
        
        self.id = ""
        self.name = ""
        
    }
}

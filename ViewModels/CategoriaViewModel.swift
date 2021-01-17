//
//  CategoriaViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI
import Firebase

class CategoriaViewModel : ObservableObject {
    
    @Published var isNewData = false
    
    @Published var categorias: [CategoriaModel] = []
    
    @Published var noData = false
    
    @Published var id = ""
    @Published var name = ""
    
    init() {
        
        fetchData()
        
    }
    
    func fetchData() {
        
        COLLECTION_CATEGORIAS.order(by: "name").addSnapshotListener({ (snap, err) in
            
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
                    
                    let cat = try! doc.document.data(as: CategoriaModel.self)!
                    
                    DispatchQueue.main.async {
                        self.categorias.append(cat)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.categorias.removeAll { (cat) -> Bool in
                        return cat.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.categorias.firstIndex { (cat) -> Bool in
                        return cat.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                        self.categorias[index].name = doc.document.data()["name"] as! String
                        
                    }
                    
                }
            }
        })
    }
    
    func saveData() {
        
        // Updating Item.....
        
        if id != "" {
            
            COLLECTION_CATEGORIAS.document(id).updateData([
                
                "name": self.name
                
            ]) { (err) in
                
                self.id = ""
                
                self.isNewData.toggle()
                
                self.name = ""
                
            }
            
            return
        }
        
        let cat = CategoriaModel(name: name)
        
        let _ = try! COLLECTION_CATEGORIAS.addDocument(from: cat) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.isNewData.toggle()
            
            self.name = ""
            
        }
        
    }
    
    func EditItem(item: CategoriaModel){
        
        self.id = item.id!
        self.name = item.name
        
        self.isNewData.toggle()
    }
    
    func DeleteItem(id: String){
        
        COLLECTION_CATEGORIAS.document(id).delete { (err) in
            
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

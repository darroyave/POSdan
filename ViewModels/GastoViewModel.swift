//
//  GastoViewModel.swift
//  POSdan
//
//  Created by Dannover Arroyave on 3/01/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class GastoViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var note = ""
    @Published var date = Date()
    @Published var amount = 0
    
    // For NewData Sheet...
    @Published var isNewData = false
    
    // Checking And Updating Date....
    
    // Storing Update Item...
    @Published var updateItem : GastoModel!
    
    let calender = Calendar.current
    
    @Published var gastos: [GastoModel] = []
    
    @Published var noData = false
    
    init() {
        fetchData()
    }
    
    func checkDate()->String {
        
        if calender.isDateInToday(date) {
            
            return "Today"
        }
        else if calender.isDateInTomorrow(date) {
            
            return "Tomorrow"
            
        }
        else {
            return "Other day"
        }
    }
    
    func updateDate(value: String) {
        
        if value == "Today"{date = Date()}
        else if value == "Tomorrow"{
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        }
        else{
            // do something...
        }
    }
    
    func addGasto(name: String, note: String, date: Date, amount: Int) {
        
        let gasto = GastoModel(name: name, note: note, date: date, amount: amount)
        
        let _ = try! COLLECTION_EXPENSE.addDocument(from: gasto) { (err) in
            
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func fetchData() {
        
        COLLECTION_EXPENSE.addSnapshotListener({ (snap, err) in
            
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
                    
                    let g = try! doc.document.data(as: GastoModel.self)!
                    
                    DispatchQueue.main.async {
                        self.gastos.append(g)
                    }
                }
                
                if doc.type == .removed {
                    
                    let id = doc.document.documentID
                    
                    self.gastos.removeAll { (g) -> Bool in
                        return g.id == id
                    }
                }
                
                if doc.type == .modified {
                    
                    let id = doc.document.documentID
                    
                    let index = self.gastos.firstIndex { (g) -> Bool in
                        return g.id == id
                    } ?? -1
                    
                    if index != -1 {
                        
                    }
                    
                }
            }
        })
    }
    
    func EditItem(item: GastoModel){
        
        updateItem = item
        
        // togging the newDataView....
        name = item.name
        note = item.note
        amount = item.amount
        date = item.date
        
        isNewData.toggle()
    }
    
    func deletePost(id: String){
        
        COLLECTION_EXPENSE.document(id).delete { (err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
        }
        
    }
}

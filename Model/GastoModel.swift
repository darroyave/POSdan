//
//  Gasto.swift
//  POSdan
//
//  Created by Dannover Arroyave on 3/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct GastoModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var name: String
    var note: String
    var date: Date
    var amount: Int
    
    enum CodingKeys: String,CodingKey {
        case id
        case name
        case note
        case date
        case amount
    }
}

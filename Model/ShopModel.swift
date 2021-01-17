//
//  Shop.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct ShopModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var address: String
    var contact: String
    var moneda: String
    var email: String
    var name: String
    var tax: Int
    
    enum CodingKeys: String,CodingKey {
        case id
        case address
        case contact
        case moneda
        case email
        case name
        case tax
    }
}


//
//  Supplier.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct ProveedorModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var address: String
    var contactperson: String
    var email: String
    var name: String
    var phone: String
    
    enum CodingKeys: String,CodingKey {
        case id
        case address
        case contactperson
        case email
        case name
        case phone
    }
}

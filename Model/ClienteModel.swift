//
//  Customer.swift
//  POSdan
//
//  Created by Dannover Arroyave on 3/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct ClienteModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var address: String
    var email: String
    var name: String
    var phone: String
    
    enum CodingKeys: String,CodingKey {
        case id
        case address
        case email
        case name
        case phone
    }
}

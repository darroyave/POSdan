//
//  Usuario.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct UsuarioModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var email: String
    var phone: String
    var tipo: String
    
    enum CodingKeys: String,CodingKey {
        case id
        case email
        case phone
        case tipo
    }
}

//
//  Categoria.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct CategoriaModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var name: String
    
    enum CodingKeys: String,CodingKey {
        case id
        case name
    }
}


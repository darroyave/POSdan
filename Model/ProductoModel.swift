//
//  Producto.swift
//  POSdan
//
//  Created by Dannover Arroyave on 2/01/21.
//

import Firebase
import FirebaseFirestoreSwift

struct ProductoModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var code: String
    var sell_price: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case code
        case sell_price
    }
}



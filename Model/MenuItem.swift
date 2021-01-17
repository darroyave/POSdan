//
//  Menu.swift
//  POSdan
//
//  Created by Dannover Arroyave on 1/01/21.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id: Int
    var title: String
    var image: String
    var color: Color
}

var menus = [
    MenuItem(
        id: 1,
        title: "Clientes",
        image: "Illustration 1",
        color: Color(#colorLiteral(red: 0, green: 0.5217629075, blue: 1, alpha: 1))
    ),
    MenuItem(
        id: 2,
        title: "Proveedores",
        image: "Illustration 2",
        color: Color(#colorLiteral(red: 0.3150139749, green: 0, blue: 0.8982304931, alpha: 1))
    ),
    MenuItem(
        id: 3,
        title: "Productos",
        image: "Illustration 3",
        color: Color(#colorLiteral(red: 0, green: 0.7283110023, blue: 1, alpha: 1))
    ),
    MenuItem(
        id: 4,
        title: "Gastos",
        image: "Illustration 4",
        color: Color(#colorLiteral(red: 0.9467853904, green: 0.2021691203, blue: 0.3819385171, alpha: 1))
    ),
    MenuItem(
        id: 5,
        title: "POS",
        image: "Illustration 5",
        color: Color(#colorLiteral(red: 0.9721538424, green: 0.2151708901, blue: 0.5066347718, alpha: 1))
    ),
    MenuItem(
        id: 6,
        title: "Ordenes",
        image: "Illustration 6",
        color: Color(#colorLiteral(red: 1, green: 0.3477956653, blue: 0.3974102139, alpha: 1))
    ),
    MenuItem(
        id: 7,
        title: "Reportes",
        image: "Illustration 7",
        color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
    )
]


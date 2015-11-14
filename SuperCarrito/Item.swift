//
//  Item.swift
//  SuperCarrito
//
//  Created by Rodolfo Castillo on 14/11/15.
//  Copyright © 2015 Rodolfo Castillo. All rights reserved.
//

import Foundation

class Item {
    var nombre: String!
    var precio: String!
    var ID: String!
    
    init(name: String, price: String, iden: String) {
        self.nombre = name
        self.precio = price
        self.ID = iden
    }
}
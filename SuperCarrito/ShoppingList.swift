//
//  ShoppingList.swift
//  SuperCarrito
//
//  Created by Rodolfo Castillo on 14/11/15.
//  Copyright © 2015 Rodolfo Castillo. All rights reserved.
//

import Foundation

class ShoppingList {
    
    var list: [Item]?
    
    init(){
        self.list = [Item]()
    }
    
    func addItems(name: String, price: String, id: String){
        self.list?.append(Item(name: name, price: price, iden: id))
    }
    
}
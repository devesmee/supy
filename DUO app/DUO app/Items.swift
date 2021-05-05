//
//  Items.swift
//  DUO app
//
//  Created by Student on 10/11/19.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import Foundation

var counter: Int = 0

class Item{
    // Properties.
    var Name: String
    var Quantity: Int
    
    // Initializer / Constructor.
    init(name: String){
        self.Name = name
        self.Quantity = 1
    }
}

class Items{
    // Properties.
    var ListItems: [Item]
    
    static let shared = Items()
    
    // Initializer / Constructor.
    private init()
    {
        self.ListItems = []
    }
    
    // Add item to list.
    func AddItem(item: Item)
    {
        let doesExist = ListItems.contains(where: {$0.Name == item.Name})
        switch doesExist{
        case true:
            for i in ListItems
            {
                if (i.Name == item.Name)
                {
                    i.Quantity += 1
                }
            }
            break
      
        case false:
            item.Quantity = 1
            self.ListItems.append(item)
            break
        }
    }
    
    // Get specific item from list.
    func GetItem(itemName: String) -> Item
    {
        var item = Item(name: "")
        for i in ListItems{
            if i.Name == itemName
            {
                item = i
            }
        }
        return item
    }
    
    // Change the quantity of the item.
    func ChangeQuantity(name: String, quantity: Int)
    {
        let item = self.GetItem(itemName: name)
        item.Quantity = quantity
    }
    
    //Return quantity of a certain item.
    func GetQuantity(itemName: String) -> Int
    {
        var q = 0
        for item in ListItems {
            if item.Name == itemName
            {
                q = item.Quantity
            }
        }
        return q
    }
}



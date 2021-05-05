//
//  Charity.swift
//  DUO app
//
//  Created by Student on 11/10/2019.
//  Copyright © 2019 Angel & Esmee. All rights reserved.
//

import Foundation

class Charity: Decodable {
    var name: String
    var address: String
    var phonenr: String
    var deliverymethod: String
    
    init(name: String, address: String, phonenr: String, deliverymethod: String){
        self.name = name
        self.address = address
        self.phonenr = phonenr
        self.deliverymethod = deliverymethod
    }
}

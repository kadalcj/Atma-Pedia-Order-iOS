//
//  Items.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/23.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import Foundation

class Items: NSObject {
    var name: String
    var desc: String
    var price: Double
    var category: String
    var imageURL: String
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String ?? ""
        self.desc = json["description"] as? String ?? ""
        self.price = json["price"] as? Double ?? 0
        self.category = json["category"] as? String ?? ""
        self.imageURL = json["image_url"] as? String ?? ""
    }
    
    func printData() {
        print(
            "name", self.name,
            "description", self.desc,
            "price", self.price,
            "category", self.category,
            "image_url", self.imageURL
        )
    }
}

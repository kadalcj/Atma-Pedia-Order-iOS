//
//  Categories.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/26.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import Foundation

class Categories: NSObject, Codable {
    var categories: String
    var image_url: String
    
    init(json: [String: Any]) {
        self.categories = json["name"] as? String ?? ""
        self.image_url = json["image_url"] as? String ?? ""
    }
    
    func printData() {
        print(
            "name", self.categories,
            "image_url", self.image_url
        )
    }
}

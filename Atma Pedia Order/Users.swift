//
//  Users.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/28.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import Foundation

class Users: NSObject {
    var name: String
    var email: String
    var pass: String
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.pass = json["password"] as? String ?? ""
    }
    
    func printData() {
        print(
            "name", self.name,
            "email", self.email,
            "password", self.pass
        )
    }
}

//
//  MainDetailController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/26.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class MainDetailController: UIViewController {
    
    var items: Items!
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMenu()
    }
    
    func showMenu() {
        lblMenu.text = items.name
        lblCategory.text = items.category
        lblPrice.text =  String(format: "Rp. %.2f", items.price)
        txtDesc.text = items.desc
        
        let imageURL = URL(string: items.imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!)
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imgMenu.image = image
                }
            }
        }
    }
}

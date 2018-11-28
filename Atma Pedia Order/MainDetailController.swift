//
//  MainDetailController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/26.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class MainDetailController: UIViewController {
    let URL_JSON = "http://192.168.100.7:8000/api/order/create"
    
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
    @IBAction func btnOrder(_ sender: Any) {
        let NAME = self.items.name
        let DESC = self.items.desc
        let PRICE = self.items.price
        let CATEG = self.items.category
        let IMGURL = self.items.imageURL

        createOrder (
            name: NAME,
            desc: DESC,
            price: PRICE,
            category: CATEG,
            imageUrl: IMGURL
        )
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
    
    fileprivate func createOrder(name: String, desc: String, price: Double, category: String, imageUrl: String) {
        let parameters: [String: Any] = ["name": name, "description": desc, "price": price, "category": category, "image_url": imageUrl]

        guard let url = URL(string: URL_JSON) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, err) in
            if let response = response {
                print(response)
            }
            if let data = data{
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch{
                    print (error)
                }
            }
        }.resume()
    }
}

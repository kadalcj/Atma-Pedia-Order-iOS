//
//  YourOrderController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/19.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class YourOrderController: UITableViewController {
    let URL_JSON = "http://192.168.100.7:8000/api/order/"
    
    var items = [Items]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSON(urlString: URL_JSON)
    }
    
    @IBAction func btnRefresh(_ sender: Any) {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })    }
    
    @IBAction func btnPay(_ sender: Any) {
        deleteJSON()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTable", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = String(format: "Rp. %.2f", items[indexPath.row].price)
        
        let imageURL = URL(string: items[indexPath.row].imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!)
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        }
        
        return cell
    }
    
    //Get
    fileprivate func getJSON(urlString: String) {
        let url = URL(string: urlString)
        print(url!)
        URLSession.shared.dataTask(with: url!) {
            (data, response, err) in
            if err != nil {
                print("#Order# Error 1: err != nil")
            }
            else {
                if let useable = data {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        print(jsonObject)
                        
                        let item = jsonObject as? [AnyObject]
                        for itm in item! {
                            let i = Items(json: itm as! [String: Any])
                            self.items.append(i)
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.tableView.reloadData()
                        })
                    }
                    catch {
                        print("#Order# Error 2: under the else condition *catch")
                    }
                }
            }
        }.resume()
    }
    
    //Delete
    fileprivate func deleteJSON(){
        guard let url = URL(string: URL_JSON + "delete") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) {
            (data, response, err) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
}

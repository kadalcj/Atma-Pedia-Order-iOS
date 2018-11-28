//
//  MainMenuController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/26.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class MainMenuController: UITableViewController {
    var category: Categories!
    let URL_JSON = "http://192.168.100.7:8000/api/menu/"
    
    var items = [Items]()
    
    override func viewDidLoad() {

        getJSON(urlString: URL_JSON, urlMenu: category.categories)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTable", for: indexPath)
        
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
    
    fileprivate func getJSON(urlString: String, urlMenu: String) {
        let url = URL(string: urlString)?.appendingPathComponent(urlMenu)
        print(url!)
        URLSession.shared.dataTask(with: url!) {
            (data, response, err) in
            if err != nil {
                print("#Items# Error 1: err != nil")
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
                        print("#Items# Error 2: under the else condition *catch")
                    }
                }
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailVC", sender: (Any).self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVC" {
            let menuDetailController = segue.destination as! MainDetailController
            
            let index = tableView.indexPathForSelectedRow!.row
            
            menuDetailController.items = items[index]
        }
    }
}

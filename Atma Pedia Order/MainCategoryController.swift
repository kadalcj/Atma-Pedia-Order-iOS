//
//  MainCategoryController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/23.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class MainCategoryController: UITableViewController {
    
    let URL_JSON = "https://atmapediaorder.nolyfeteam.site/public/api/categories/"
    
    var categories = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSON(urlString: URL_JSON);
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesTable", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].categories
        
        let imageURL = URL(string: categories[indexPath.row].image_url)
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
    
    fileprivate func getJSON(urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {
            (data, response, err) in
            if err != nil {
                print("#Categories# Error 1: err != nil")
            }
            else {
                if let useable = data {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        print(jsonObject)
                        
                        let categories = jsonObject as? [AnyObject]
                        for cat in categories! {
                            let c = Categories(json: cat as! [String: Any])
                            self.categories.append(c)
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.tableView.reloadData()
                        })
                    }
                    catch {
                        print("#Categories# Error 2: under the else condition *catch")
                    }
                }
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "menuVC", sender: (Any).self)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "menuVC" {
//            let mainMenuController = segue.destination as! MainMenuController
//
//            let index = tableView.indexPathForSelectedRow!.row
//
//            mainMenuController.category = categories[index].categories
//        }
//    }
}

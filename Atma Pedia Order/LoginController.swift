//
//  ViewController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/19.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBAction func btnRegis(_ sender: Any) {
        performSegue(withIdentifier: "regisVC", sender: (Any).self)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        performSegue(withIdentifier: "loginVC", sender: (Any).self)
    }
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Hide NavBar
        //navigationController?.setNavigationBarHidden(true, animated: true)
    }
}


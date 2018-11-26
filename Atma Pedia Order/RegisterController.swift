//
//  RegisterController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/19.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var txtNama: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UnHide NavBar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //Hide keyboard from random tap on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        performSegue(withIdentifier: "loginVC", sender: (Any).self)
    }
    @IBAction func btnLogin(_ sender: Any) {
        performSegue(withIdentifier: "loginVC", sender: (Any).self)
    }
}

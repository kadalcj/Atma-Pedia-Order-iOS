//
//  RegisterController.swift
//  Atma Pedia Order
//
//  Created by Sul on 2018/11/19.
//  Copyright © 2018 Sul Compagnie. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    let URL_JSON = "http://192.168.100.7:8000/api/user/create"
    
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
        let NAME = txtNama.text!
        let EMAIL = txtEmail.text!
        let PASS = txtPassword.text!
        
        register(
            name: NAME,
            email: EMAIL,
            pass: PASS
            )
        
        performSegue(withIdentifier: "loginVC", sender: (Any).self)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        performSegue(withIdentifier: "loginVC", sender: (Any).self)
    }
    
    fileprivate func register(name: String, email: String, pass: String) {
        let parameters: [String: Any] = ["name": name, "email": email, "password": pass]
        
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

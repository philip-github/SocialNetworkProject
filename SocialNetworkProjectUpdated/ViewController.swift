//
//  ViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/30/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if self.loginEmailTextField.text != "" && self.loginPasswordTextField.text != ""{
            
            
            Auth.auth().signIn(withEmail: self.loginEmailTextField.text!, password: self.loginPasswordTextField.text!) { (data, error) in
                
                if error == nil {
                    
                    let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    UIApplication.shared.windows.first{ $0.isKeyWindow}?.rootViewController = mainStoryBoard.instantiateViewController(identifier: "WelcomeNav")
                    
                } else {
                    
                    print("Somthin went wrong with signing in \(String(describing: error))")
                }
            }
        }
    }
}


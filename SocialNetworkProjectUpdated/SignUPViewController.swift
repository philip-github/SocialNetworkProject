//
//  SignUPViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/30/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class SignUPViewController: UIViewController {

    @IBOutlet weak var signUpUsernameTextField: UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        
        if self.signUpUsernameTextField.text != "" && self.signUpEmailTextField.text != "" && self.signUpPasswordTextField.text != "" {
            
            let user = UserModel(userName: self.signUpUsernameTextField.text!, userId: nil, password: self.signUpPasswordTextField.text!, userImg: nil, email: self.signUpEmailTextField.text!)
            
            FirebaseServices.shared.signUp(user: user) { (error) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }else {
                    print("Somthing went wrong creating user \(String(describing: error))")
                }
            }
        }
    }
}

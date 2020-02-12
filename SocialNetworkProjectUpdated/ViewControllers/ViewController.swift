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
    
    let loginVM = LoginViewModel()
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if loginVM.isValid(email: self.loginEmailTextField.text ?? "", password: self.loginPasswordTextField.text ?? "") {
            
            loginVM.performLogin(email: self.loginEmailTextField.text!, password: self.loginPasswordTextField.text!) { (error) in
                if error == nil {
                    let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
                    UIApplication.shared.windows.first{ $0.isKeyWindow}?.rootViewController = mainStoryBoard.instantiateViewController(identifier: "WelcomeNav")
                }else {
                    Alert().showAlert(vc: self, title: "Error", message: "NO Users Found")
                    print("Somthin Went wrong with login \(String(describing: error?.localizedDescription))")
                }
            }
        }else{
            Alert().showAlert(vc: self, title: "Error", message: "Must enter valid email and password")
        }
    }
}


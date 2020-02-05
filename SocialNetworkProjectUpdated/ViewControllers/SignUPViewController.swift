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
    
    let signUpVM = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        
        if signUpVM.isValid(userName: self.signUpUsernameTextField.text!, password: self.signUpPasswordTextField.text!, email: self.signUpEmailTextField.text!){
            
            signUpVM.perfomanceSignUp(userName: self.signUpUsernameTextField.text, password: self.signUpPasswordTextField.text, email: self.signUpEmailTextField.text) { (error) in
                
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
}


//extension SignUPViewController: SignUpViewModelProtocol {
//
//    func performSignUpUsingDelegate() {
//       signUpVM.isValid(userName: self.signUpUsernameTextField.text ?? "", password: self.signUpPasswordTextField.text ?? "", email: self.signUpEmailTextField.text ?? "")
//    }
//}



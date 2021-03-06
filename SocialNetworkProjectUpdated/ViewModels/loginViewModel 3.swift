//
//  loginViewModel.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/4/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    func performLogin(email: String, password: String, complitionHandler: @escaping (Error?) -> Void) {
        
        FirebaseServices.shared.logIn(email: email, password: password) { (error) in
            complitionHandler(error)
        }
    }
    
    func isValid(email: String, password: String) -> Bool{
        
        if email == "" && password == ""{
            return false
        }else{
            return true
        }
    }
}

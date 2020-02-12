//
//  SignUpViewModel.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/4/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import Foundation


class SignUpViewModel {
    
    func perfomanceSignUp(userName: String?, password: String?, email: String? ,complitionHandler: ((Error?) -> ())?){
        
        let user = UserModel(userName: userName, userId: nil, password: password, userImg: nil, email: email)
                   
                   FirebaseServices.shared.signUp(user: user) { (error) in
                    complitionHandler?(error)
        }
    }
    
    
    func isValid(userName: String, password: String, email: String) -> Bool{
        
        if userName == "" && password == "" && email == ""{
            print("Must enter a valid entries")
            return false
        }else{
            return true
        }
    }
}

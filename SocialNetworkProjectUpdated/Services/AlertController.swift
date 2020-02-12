//
//  AlertController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/5/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import Foundation
import UIKit


struct Alert{
    
    func showAlert(vc: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}

//
//  BaseViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/30/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem?.title = ""
        
        let backButton = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        self.setupNavigationBarWithColor(UIColor.white)
        
    }
    
    
    func setupNavigationBarWithColor(_ color: UIColor) {
        let font = UIFont.boldSystemFont(ofSize: 20);
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor : color ,
             NSAttributedString.Key.font : font as Any]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

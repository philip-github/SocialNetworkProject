//
//  WelcomeViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/30/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    
    let dbRef = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.profileImageView.layer.borderWidth = 2
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let myUserId = Auth.auth().currentUser?.uid
        
        dbRef.child("Users").child(myUserId!).observeSingleEvent(of: .value) { (snapShot) in
            let userData = snapShot.value as! [String:Any]
            
            let userName = userData["Username"]!
            
            DispatchQueue.main.async {
                self.userNameLabel.text = "Welcome : \(userName)"
                
            }
            
        }

        
        FirebaseServices.shared.getUserImage { (data, error) in
            
            if error == nil {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data!)
                }
            }else {
                print("Somthin went wrong getting user profile image : \(String(describing: error))")
            }
        }
    }
    

    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        do {
           try Auth.auth().signOut()
            let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.shared.windows.first{ $0.isKeyWindow}?.rootViewController = mainStoryBoard.instantiateViewController(identifier: "ViewController")
        } catch {
            print("Somthing went wrong with logout !!")
        }
    }
    
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "EditUserProfileViewController")
        navigationController?.pushViewController(vc, animated: true)
 
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "AddPostViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}


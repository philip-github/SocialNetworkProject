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

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postsCV: UICollectionView!
    
    let dbRef = Database.database().reference()
    var data = [[String:Any]]()
    
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
            
            self.userNameLabel.text = "Welcome : \(userName)"
            
            
        }

        
        FirebaseServices.shared.getUserImage { (data, error) in
            
            if error == nil {
                    self.profileImageView.image = UIImage(data: data!)
            }else {
                print("Somthin went wrong getting user profile image : \(String(describing: error))")
            }
        }
        getPosts()
        
    }
    
    
    
    func getPosts(){
        FirebaseServices.shared.getPosts { (posts) in
            guard let pst = posts else {
                print("Somthin went wrong fetching posts")
                return
            }
            self.data = pst
            
            if self.data.count == 0{
                print("No posts Found")
            }else{
                self.postsCV.reloadData()
            }
        }
    }
    
    
    
//    func getPosts(){
//
//        FirebaseServices.shared.getPosts { (posts) in
//            if posts != nil{
//                self.data = posts!
//            }
//
//            if self.data.count == 0{
//                print("No posts found!")
//            }else{
//                self.postsCV.reloadData()
//            }
//        }
//    }

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



extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PostCustomCVCell
        
        let post = data[indexPath.row]
        cell?.updatePost(userName: post["userId"] as! String, postDesc: post["comment"] as! String)
        return cell!
    }
    
    
}

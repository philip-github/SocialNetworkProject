//
//  UsersViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/31/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class UsersViewController: BaseViewController {
    
    @IBOutlet weak var usersCV: UICollectionView!


    
    var data = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUsers()
    }
    
    func getUsers(){
        
        FirebaseServices.shared.getUsers { (userArray) in
            guard let users = userArray else {
                print("Somthing went wrong")
                return
            }
            self.data = users
            
            if self.data.count == 0{
                print("No users found ")
            } else {
                self.usersCV.reloadData()
            }
        }
    }
}



extension UsersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! myCustomCVCell
        let user = data[indexPath.row]
        
        cell.updateCell(img: user.userImg!, userLabel: user.userName!, id: user.userId!)
        
        return cell
    }
}

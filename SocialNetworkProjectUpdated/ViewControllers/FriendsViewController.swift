//
//  FriendsViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/1/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class FriendsViewController: BaseViewController {
    
    @IBOutlet weak var friendsCV: UICollectionView!
    
    var data = [UserModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFriends()

    }
    
    func getFriends(){
        
        FirebaseServices.shared.getFriends { (friendsArray) in
            guard let friends = friendsArray else {
                print("Somthing went wrong with getting friends")
                return
            }
            
            self.data = friends
            
            if self.data.count == 0{
                print("No friends found")
            }
            else{
                self.friendsCV.reloadData()
            }
        }
    }
}


extension FriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FriendsCustomCVCell
        
        let friend = data[indexPath.row]
        
        cell.updateData(img: friend.userImg!, friendlbl: friend.userName!)
        
        return cell
        
    }
}

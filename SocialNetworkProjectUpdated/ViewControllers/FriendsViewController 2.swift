//
//  FriendsViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/1/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class FriendsViewController: BaseViewController {
    
    lazy var refresher : UIRefreshControl = {
        let refreshController = UIRefreshControl()
        refreshController.tintColor = .white
        refreshController.addTarget(self, action: #selector(getFriends), for: .valueChanged)
        
        return refreshController
    }()
    
    @IBOutlet weak var friendsCV: UICollectionView!
    
    var data = [UserModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsCV.refreshControl = refresher
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFriends()
    }
    
    
    
    @objc func getFriends(){
        
        FirebaseServices.shared.getFriends { (friendsArray) in
            if let friends = friendsArray {
                
                self.data = friends
                
                if self.data.count == 0{
                    print("No friends found")
                }
                else{
                    DispatchQueue.main.async {
                        self.friendsCV.reloadData()
                        self.refresher.endRefreshing()
                    }
                }
            }else{
                Alert.init().showAlert(vc: self, title: "Alert", message: "No Friends Found")
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
        
        cell.updateData(img: friend.userImg!, friendlbl: friend.userName!, friendId: friend.userId!)
        
        return cell
    }
}

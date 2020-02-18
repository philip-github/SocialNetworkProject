//
//  UsersViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/31/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import FirebaseAuth

class UsersViewController: BaseViewController {
    
    @IBOutlet weak var usersCV: UICollectionView!
    
    lazy var refresher : UIRefreshControl = {
        let refreshController = UIRefreshControl()
        refreshController.tintColor = .white
        refreshController.addTarget(self, action: #selector(getUsers), for: .valueChanged)
        
        return refreshController
    }()

    var data = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersCV.refreshControl = refresher
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUsers()
    }
    
    @objc func getUsers(){
        
        FirebaseServices.shared.getUsers { (userArray) in
            guard let users = userArray else {
                print("Somthing went wrong")
                return
            }
            self.data = users
            
            if self.data.count == 0{
                print("No users found")
            } else {
                DispatchQueue.main.async {
                    
                    self.usersCV.reloadData()
                    self.refresher.endRefreshing()
                }
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
        let user = self.data[indexPath.row]
        cell.updateCell(img: user.userImg ?? UIImage(), userLabel: user.userName!, id: user.userId!)
        cell.delegate = self
        return cell
    }
}


extension UsersViewController: myCustomCellProtocol{
    func updateFriendId(id: String) {
        print(id)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "ChatViewController") as ChatViewController
        vc.myFriendId = id
        present(vc,animated: true)
    }
}

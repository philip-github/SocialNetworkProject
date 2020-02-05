//
//  PostsViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/5/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PostsViewController: BaseViewController{
    
    
    
    @IBOutlet weak var postsCV: UICollectionView!
    
    var data = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
    
}


extension PostsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PostCustomCVCell
        
        let post = data[indexPath.row]
        cell?.updatePost(userImg: post["userImg"] as? UIImage ?? UIImage(), postImg: post["postImg"] as? UIImage ?? UIImage(), userName: post["userName"] as? String ?? "nil", postDesc: post["comment"] as? String ?? "nil")
        
        return cell!
        
    }
}

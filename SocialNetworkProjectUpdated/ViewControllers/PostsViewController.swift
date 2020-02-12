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
import ViewAnimator

class PostsViewController: BaseViewController{
    
    
    @IBOutlet weak var postsCV: UICollectionView!
    
    lazy var refresher : UIRefreshControl = {
        let refreshController = UIRefreshControl()
        refreshController.tintColor = .white
        refreshController.addTarget(self, action: #selector(getPosts), for: .valueChanged)
        
        return refreshController
    }()
    
    var data = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsCV.refreshControl = refresher
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getPosts()
    }
    
    @objc func getPosts(){
        FirebaseServices.shared.getPosts { (posts) in
            guard let myPosts = posts else {
                print("Somthin went wrong fetching posts")
                return
            }
            self.data = myPosts
            
            if self.data.count == 0{
                print("No posts Found")
            }else{
                DispatchQueue.main.async { [weak self] in
                    self?.postsCV.reloadData()
                    self?.refresher.endRefreshing()
                }
            }
        }
    }
}


extension PostsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
              let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
              // no array brackets here.
              UIView.animate(views: [cell],
                             animations: [zoomAnimation, rotateAnimation],
                             duration: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PostCustomCVCell
        
        let post = data[indexPath.row]
        cell?.updatePost(userImg: post["userImg"] as? UIImage ?? UIImage(), postImg: post["postImg"] as? UIImage ?? UIImage(), userName: post["userName"] as? String ?? "nil", postDesc: post["comment"] as? String ?? "nil")
        
        return cell!
    }
}

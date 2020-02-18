//
//  myCustomCVCell.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/31/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

protocol myCustomCellProtocol {
    func updateFriendId(id: String)
}


class myCustomCVCell: UICollectionViewCell {
    
    let chatViewController = ChatViewController()
    
    var delegate: myCustomCellProtocol?
    
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userLbl : UILabel!
    var userId : String?
    
    
    func updateCell(img : UIImage , userLabel: String, id : String){
        self.userImage.image = img
        self.userLbl.text = userLabel
        self.userId = id
        checkFirends(id: id)
    }
    
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        frame.size.height = 119
        self.userImage.layer.borderWidth = 1
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.clipsToBounds = true
    }
    
    
    func checkFirends(id: String){
        FirebaseServices.shared.checkFriends { (friends) in
            if friends.keys.contains(id){
                DispatchQueue.main.async {
                    self.addFriendButton.isHidden = true
                }
            }
        }
    }
    
    
    @IBAction func chatButtonTapped(_ sender: Any) {
        guard let Id = self.userId else{
            print("somthing went wrong")
            return
        }
        delegate?.updateFriendId(id: Id)
    }
    
    
    @IBAction func addFriendButtonTapped(_ sender: UIButton) {
        
        let id = userId
        
        FirebaseServices.shared.addFreind(friendId: id!) { (error) in
            if error == nil {
                print("A new friend added to your friends list")
            }else {
                print("Somthing went wrong adding a new friend")
            }
        }
    }
}


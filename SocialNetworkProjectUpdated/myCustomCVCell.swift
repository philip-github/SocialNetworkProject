//
//  myCustomCVCell.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/31/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class myCustomCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userLbl : UILabel!
    
    var userId : String?
    
    func updateCell(img : UIImage , userLabel: String, id : String){
        self.userImage.image = img
        self.userLbl.text = userLabel
        self.userId = id
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        frame.size.height = 119
        self.userImage.layer.borderWidth = 1
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.clipsToBounds = true
    }
    
    
    @IBAction func addFriendButtonTapped(_ sender: Any) {
        
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

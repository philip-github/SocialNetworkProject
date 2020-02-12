//
//  FriendsCustomCVCell.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/1/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class FriendsCustomCVCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImageView : UIImageView!
    @IBOutlet weak var friendLabel : UILabel!
    var friendId : String?
    
    func updateData(img: UIImage, friendlbl: String ,friendId: String){
        
        self.friendImageView.image = img
        self.friendLabel.text = friendlbl
        self.friendId = friendId
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        frame.size.height = 119
        self.friendImageView.layer.borderWidth = 1
        self.friendImageView.layer.cornerRadius = self.friendImageView.frame.size.width / 2
        self.friendImageView.clipsToBounds = true
    }
    
    
    @IBAction func removeFriendButtonTapped(_ sender: Any) {
        let id = self.friendId
        
        FirebaseServices.shared.removeFriend(friendId: id!) { (error) in
            if error == nil {
                print("friend has been removed!!")
            }
        }
    }
}

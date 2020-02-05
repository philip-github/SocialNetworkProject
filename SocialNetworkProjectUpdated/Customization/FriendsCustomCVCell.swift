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
    
    
    func updateData(img: UIImage, friendlbl: String){
        
        self.friendImageView.image = img
        self.friendLabel.text = friendlbl
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        frame.size.height = 119
        self.friendImageView.layer.borderWidth = 1
        self.friendImageView.layer.cornerRadius = self.friendImageView.frame.size.width / 2
        self.friendImageView.clipsToBounds = true
    }
    
}

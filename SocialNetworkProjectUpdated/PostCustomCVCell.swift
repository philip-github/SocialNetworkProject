//
//  PostCustomCVCell.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/2/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class PostCustomCVCell: UICollectionViewCell {
    
    @IBOutlet weak var postUserImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postUserlbl: UILabel!
    @IBOutlet weak var postTextField: UITextView!
    
//    userImg: UIImage?, postImg: UIImage?,
    
    func updatePost(userName: String, postDesc: String){
        
//        self.postUserImageView.image = userImg
//        self.postImageView.image = postImg
        self.postUserlbl.text = userName
        self.postTextField.text = postDesc
    }
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
//        frame.size.height = 120
//        self.postUserImageView.layer.cornerRadius = self.postUserImageView.frame.size.width / 2
//        self.postUserImageView.clipsToBounds = true
        
    }
}

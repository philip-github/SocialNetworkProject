//
//  chatCustomCVCell.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/10/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import SDWebImage

class chatCustomCVCell: UICollectionViewCell {
    
    @IBOutlet weak var senderImageView: UIImageView!
    
    @IBOutlet weak var senderTextView: UITextView!
    
    
    func updateCell(message: String){
        
        self.senderTextView.text = message

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.senderImageView.layer.borderWidth = 1
        self.senderImageView.layer.cornerRadius = self.senderImageView.frame.size.width / 2
        self.senderImageView.clipsToBounds = true
    }
}

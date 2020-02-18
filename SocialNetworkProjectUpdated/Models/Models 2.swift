//
//  Models.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/30/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

struct UserModel {
    
    var userName : String?
    var userId : String?
    var password : String?
    var userImg : UIImage?
    var email: String?
}


struct ConversationModel {
    var userId: String?
    var friendId : String?
    var message: String?
    var time: String?
    var senderImage: UIImage?
    var reciverImage: UIImage?
}

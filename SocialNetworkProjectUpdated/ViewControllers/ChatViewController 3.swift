//
//  ChatViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/9/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class ChatViewController: BaseViewController {
    
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var chatCV: UICollectionView!
    
    var myFriendId : String?
    
    var data : [ConversationModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    func getMessages(){
        
        FirebaseServices.shared.getMessages(friendId: self.myFriendId!) { (messages) in
            guard let myChat = messages else{
                print("Somthing went wrong fetching messges")
                return
            }
            
//            self.data = myChat.sorted(by: {$0.Int(time) < $1.Int(time)} )
            self.data = myChat
            if self.data?.count == 0{
                
                Alert().showAlert(vc: self, title: "Alert", message: "No messages found")
            }else{
                print(self.data!)
                self.chatCV.reloadData()
            }
        }
    }
    
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        let id = self.myFriendId
        
        FirebaseServices.shared.sendMessage(friendId: id!, messageText: self.messageTextField.text) { (error) in
            if error == nil{
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}



extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell: chatCustomCVCell?

        if indexPath.row % 2 != 0{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reciver", for: indexPath) as? chatCustomCVCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sender", for: indexPath) as? chatCustomCVCell
        }

        let chat = data![indexPath.row]

        if cell?.reuseIdentifier == "sender"{
            
            cell?.updateCell(message: chat.message!)
            let storageRef = Storage.storage().reference().child("UserImage/\(chat.userId!).jpeg")

            storageRef.downloadURL { url, error in
              guard let url = url else { return }
                
                cell?.senderImageView!.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: { (image, error, cacheType, storageRef) in
                if image != nil && error != nil {
                    
                }
              })
            }
            
        }else{
            
            cell?.updateCell(message: chat.message!)
            let storageRef = Storage.storage().reference().child("UserImage/\(chat.friendId!).jpeg")

            storageRef.downloadURL { url, error in
              guard let url = url else { return }
                
                cell?.senderImageView!.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: { (image, error, cacheType, storageRef) in
                if image != nil && error != nil {
                    
                }
              })
            }
        }
        return cell!
    }
}

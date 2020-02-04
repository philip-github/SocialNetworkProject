//
//  FirebaseServices.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/30/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase



class FirebaseServices {
    static let shared = FirebaseServices()
    private init() {}
    
    let dataBaseRef = Database.database().reference()
    
    typealias complition1 = (Error?) -> Void
    typealias complition2 = (Data? , Error?) -> Void
    
    
    func saveUserImage(img: UIImage, complitionHandler: @escaping complition1){
        
        let user = Auth.auth().currentUser
        let image = img
        let imageData = image.jpegData(compressionQuality: 0)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        let imageName = "UserImage/\(String(describing: user!.uid)).jpeg"
        var storageRef =  Storage.storage().reference()
        storageRef = storageRef.child(imageName)
        storageRef.putData(imageData!, metadata: metaData) { (data, error) in
            complitionHandler(error)
        }
    }
    
    func savePostImage(id: String, img: UIImage, complitionHandler: @escaping complition1){
        let image = img
        let imageData = image.jpegData(compressionQuality: 0)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        let imageName = "PostsImages/\(String(describing: id)).jpeg"
        var storageRef = Storage.storage().reference()
        storageRef = storageRef.child(imageName)
        storageRef.putData(imageData!, metadata: metaData) { (data, error) in
            complitionHandler(error)
        }
    }
    
    func getUserImage(complitionHandler : @escaping complition2){
        
        let user = Auth.auth().currentUser
        let imageName = "UserImage/\(String(describing: user!.uid)).jpeg"
        var storageRef : StorageReference?
        storageRef = Storage.storage().reference()
        storageRef = storageRef?.child(imageName)
        storageRef?.getData(maxSize: 1*1024*1024, completion: { (data, error) in
            complitionHandler(data,error)
        })
    }
    
    
    func getPostImg(id: String, complitionHandler: @escaping complition2){
        let imageName = "PostsImages/\(String(describing: id)).jpeg"
        var storageRef = StorageReference()
        storageRef = Storage.storage().reference()
        storageRef = storageRef.child(imageName)
        storageRef.getData(maxSize: 1*1024*1024) { (data, error) in
            complitionHandler(data,error)
        }
    }
    
    
    func signUp(user: UserModel, complitionHandler: @escaping complition1) {
        
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { (data, error) in
            
            if error == nil {
                print("Creating a new user account !!")
                
                let userDict = ["Username":user.userName!,"Email":user.email!] as [String: Any]
                
                self.dataBaseRef.child("Users").child((data?.user.uid)!).setValue(userDict) { (error2, ref) in
                    complitionHandler(error2)
                }
            } else {
                print("Somthing went wrong with creating user \(String(describing: error))")
            }
        }
    }
    
    
    func getUserImage(userId: String ,ComplitionHandler: @escaping complition2){
        let imageName = "UserImage/\(userId).jpeg"
        var storageRef : StorageReference?
        storageRef = Storage.storage().reference()
        storageRef = storageRef?.child(imageName)
        storageRef?.getData(maxSize: 1*1024*1024, completion: { (data, error) in
            ComplitionHandler(data,error)
        })
    }
    
    
    func getUsers(complitionHandler : @escaping ([UserModel]?) -> Void){
        
        let currentUser = Auth.auth().currentUser
        let fetchUserGroup = DispatchGroup()
        let fetchUserComponentsGroup = DispatchGroup()
        
        fetchUserGroup.enter()
        dataBaseRef.child("Users").observeSingleEvent(of: .value) { (snapShot,error) in
            
            if error == nil {
                var userArray = [UserModel]()
                guard let snap = snapShot.value as? [String:Any] else {
                    print("Somthing went wrong getting snap shot \(String(describing: error))")
                    return
                }
                for record in snap {
                    let uid : String = record.key
                    if currentUser?.uid != uid{
                        let user = snap[uid] as? [String:Any]
                        var userModel = UserModel(userName: user!["Username"] as? String,
                                                  userId: uid,
                                                  password: nil,
                                                  userImg: nil,
                                                  email: user!["Email"] as? String)
                        
                        fetchUserComponentsGroup.enter()
                        self.getUserImage(userId: uid) { (data, error) in
                            if error == nil{
                                userModel.userImg = UIImage(data: data!)
                            }else {print("Somthing went wrong with getting image \(String(describing: error))")}
                            
                            userArray.append(userModel)
                            fetchUserComponentsGroup.leave()
                        }
                    }
                }
                fetchUserComponentsGroup.notify(queue: .main) {
                    fetchUserGroup.leave()
                }
                
                fetchUserGroup.notify(queue: .main) {
                    complitionHandler(userArray)
                }
                
            } else {
                complitionHandler(nil)
            }
        }
    }
    
    
    func  getFriends(complitionHandler : @escaping ([UserModel]?) -> Void){
        
        let user = Auth.auth().currentUser
        var friendArray : [UserModel] = []
        let friendListDispatchGroup = DispatchGroup()
        self.dataBaseRef.child("Users").child(user!.uid).child("FriendsList").observeSingleEvent(of: .value) { (friendsSnapShot) in
            
            if let friends = friendsSnapShot.value as? [String:Any]{
                for friend in friends{
                    friendListDispatchGroup.enter()
                    
                    self.dataBaseRef.child("Users").child(friend.key).observeSingleEvent(of: .value) { (snapShot) in
                        guard let singleFriend = snapShot.value as? Dictionary<String,Any> else {return}
                        var userModel = UserModel(userName: singleFriend["Username"] as? String,
                                                  userId: friend.key,
                                                  password: nil,
                                                  userImg: nil,
                                                  email: singleFriend["Email"] as? String)
                        
                        self.getUserImage(userId: userModel.userId!) { (data, error) in
                            
                            if error == nil {
                                userModel.userImg = UIImage(data: data!)
                            }
                            friendArray.append(userModel)
                            friendListDispatchGroup.leave()
                        }
                    }
                }
                friendListDispatchGroup.notify(queue: .main) {
                    complitionHandler(friendArray)
                }
            } else {
                complitionHandler(nil)
            }
        }
    }
    
    
    func addPost(img: UIImage ,postDesc: String?, complitionHandler: @escaping complition1){
        let user = Auth.auth().currentUser
        let postKey = self.dataBaseRef.child("Posts").childByAutoId().key
        let postDict = ["UserId": user?.uid, "PostDescription": postDesc ?? "" , "TimeStamp": "\(NSDate().timeIntervalSince1970)"]
        
        self.dataBaseRef.child("Posts").child(postKey!).setValue(postDict) { (error, ref) in
            if error == nil {
                self.savePostImage(id: postKey!, img: img) { (error) in
                    if error == nil {
                        complitionHandler(nil)
                    }else{
                        print("Somthin went wrong saving image to storage")
                    }
                }
            }else{
                print("Somthing went wrong adding post to database")
            }
        }
    }
    
    
    
    func getUserById(userId: String, complitionHandler: @escaping (UserModel) -> Void){
        
        self.dataBaseRef.child("Users").child(userId).observeSingleEvent(of: .value) { (snapShot) in
            guard let snap = snapShot.value as? [String:Any] else {
                print("Somthing went wrong fetching user by id")
                return
            }
            self.getUserImage(userId: userId) { (data, error) in
                if error == nil{
                    
                    let use = UserModel(userName: snap["Username"] as? String, userId: userId, password: nil, userImg: UIImage(data: data ?? Data()), email: snap["Email"] as? String )
                    complitionHandler(use)
                }else{
                    print("Somthing went wrong fetching user image")
                    
                }
            }
        }
    }
    
    
    func getPosts(complitionHandler: @escaping ([[String:Any]]?) -> Void){
        
       let fetchPostsListDispatch = DispatchGroup()
        
        var postArr = [[String:Any]]()
        self.dataBaseRef.child("Posts").observeSingleEvent(of: .value) { (snapShot) in
            guard let snap = snapShot.value as? Dictionary<String,Any> else {
                print("Somthing went wrong fetching posts from data base")
                return
        }
            for record in snap{
                fetchPostsListDispatch.enter()
                let key = record.key
                let post = snap[key] as! [String:Any]
                let postDict = ["userId":post["UserId"]!,
                                "comment":post["PostDescription"]!,
                                "timestamp":post["TimeStamp"]!]
               
                postArr.append(postDict)
                
                fetchPostsListDispatch.leave()
            }
            fetchPostsListDispatch.notify(queue: .main){
               
                complitionHandler(postArr)
                 
            }
        }
    }
    
    func addFreind(friendId : String, complitionHandler : @escaping complition1){
        let user = Auth.auth().currentUser
        self.dataBaseRef.child("Users").child(user!.uid).child("FriendsList").updateChildValues([friendId : "FriendID"]) {
            (error, ref) in
            complitionHandler(error)
        }
    }
}

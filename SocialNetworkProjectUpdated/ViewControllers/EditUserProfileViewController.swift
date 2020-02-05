//
//  EditUserProfileViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 1/30/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class EditUserProfileViewController: BaseViewController {

    @IBOutlet weak var editedProfileImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func uploadImgButtonTapped(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        present(imageController,animated: true)
    }
}



extension EditUserProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Somthing went wrong with selected Image")
            return
        }
        
        FirebaseServices.shared.saveUserImage(img: selectedImage) { (error) in
            
            if error == nil {
                self.editedProfileImgView.image = selectedImage
            }else {
                
                print("Somthing went wrong while uploading image to firebase storage \(String(describing: error))")
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

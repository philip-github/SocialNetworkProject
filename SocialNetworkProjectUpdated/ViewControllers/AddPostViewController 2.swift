//
//  AddPostViewController.swift
//  SocialNetworkProjectUpdated
//
//  Created by Philip Twal on 2/2/20.
//  Copyright © 2020 Philip Twal. All rights reserved.
//

import UIKit

class AddPostViewController: BaseViewController {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func postButtonTapped(_ sender: Any) {
        
        if self.postImageView.image == nil {
            
            Alert().showAlert(vc: self, title:"Error", message: "Error Must upload Image")
            print("Error Must upload Image")
        } else {
            
            FirebaseServices.shared.addPost(img: self.postImageView.image!, postDesc: self.postTextField.text) { (error) in
                if error == nil{
                    
                    self.navigationController?.popViewController(animated: true)
                }else{
                    print("Somthing went wrong uploading post data")
                }
            }
        }
    }
    
    
    @IBAction func imagePostButtomTapped(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
}


extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Somthin went wrong selecting the image")
            return
        }
        
        self.postImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

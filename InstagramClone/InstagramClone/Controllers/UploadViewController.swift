//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Halil Ibrahim Andic on 15.02.2023.
//

import UIKit
//import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

class UploadViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true //editing
        present(picker, animated: true, completion: nil)
    }

    @IBAction func saveClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let imageReference = mediaFolder.child("image.jpg")
            imageReference.putData(data) { (metaData, error) in
                if error != nil {
                    print("hata--1")
                    print(error?.localizedDescription)
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            print("hata--2")
                            let imageURL = url?.absoluteString
                            print(imageURL)
                        }
                    }
                }
            }
        }
    }
    
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage  // I'm not 100% sure that user selected an image. so used as? casting
        self.dismiss(animated: true, completion: nil)

    }
}

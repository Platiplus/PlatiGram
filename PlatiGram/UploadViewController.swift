//
//  UploadViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 19/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import MobileCoreServices

class UploadViewController: UIViewController {
    
    private var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionView: UITextView!
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        captionView.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        captionView.text = ""

    }
    
    @IBAction func takePhotoClicked(_ sender: Any) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
         imagePicker.sourceType = .camera
        }
        
        else{
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        print("User canceled the camera/photo library")
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == (kUTTypeImage as String){
            //Photo
            self.photoView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }else{
            //Video
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

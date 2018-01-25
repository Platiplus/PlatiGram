//
//  photoPostViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 23/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Firebase

class PhotoPostTableViewController: UITableViewController {
    
    var photo: UIImage!
    
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var newPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPhoto.image = photo
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any){
        self.performSegue(withIdentifier: "unwindSelect", sender: self)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        AppDelegate.instance().showActivityIndicator()
        let uid = Auth.auth().currentUser!.uid
        let dbRef = Database.database().reference()
        let storage = Storage.storage().reference(forURL:"gs://platigram.appspot.com")
        let timeStamp = NSDate().timeIntervalSince1970
        
        let key = dbRef.child("posts").childByAutoId().key
        let imageRef = storage.child("posts").child(uid).child("\(key).jpg")
        
        
        let data = UIImageJPEGRepresentation(self.photo!, 0.6)
        let uploadTask = imageRef.putData(data!, metadata: nil) {(metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                return }
            
            imageRef.downloadURL(completion: {(url, error) in
                if let url = url {
                    let feed = ["userID": uid,
                                "pathToImage" : url.absoluteString,
                                "likes" : 0,
                                "comments" : 0,
                                "shares" : 0,
                                "timeStamp" : timeStamp,
                                "caption" : self.captionTextView.text!,
                                "author" : Auth.auth().currentUser!.displayName!,
                                "postID" : key]	 as [String: Any]
                    
                    let postFeed = ["\(key)" : feed]
                    
                    dbRef.child("posts").updateChildValues(postFeed)
                    AppDelegate.instance().dismissActivityIndicator()
                    self.performSegue(withIdentifier: "unwindSelect", sender: self)
                }
            })
        }
        uploadTask.resume()
    }
}

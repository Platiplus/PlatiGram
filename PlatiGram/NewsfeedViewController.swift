//
//  NewsfeedViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 16/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Firebase

class NewsfeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post]()
    var following = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grabFollowerPosts()
    }
    
    func grabFollowerPosts(){
        
        let dbRef = Database.database().reference()
        dbRef.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
            
            let users = snapshot.value as! [String : AnyObject]
            
            for(_, value) in users{
                if let uid = value["uid"] as? String {
                    if uid == Auth.auth().currentUser?.uid {
                        if let followingUsers = value["following"] as? [String : String]{
                            for(_,user) in followingUsers {
                                self.following.append(user)
                            }
                        }
                        self.following.append(Auth.auth().currentUser!.uid)
                        dbRef.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                            
                            let postsSnap = snap.value as! [String : AnyObject]
                            for(_,post) in postsSnap{
                                if let userID = post["userID"] as? String{
                                    for each in self.following{
                                        if each == userID {
                                            let posst = Post()
                                                if let author = post["author"] as? String,
//                                                let numberOfLikes = post["numberOfLikes"] as? Int,
                                                let pathToImage = post["pathToImage"] as? String,
                                                let postID = post["postID"] as? String,
//                                                let numberOfComments = post["numberOfComments"] as? Int,
//                                                let numberOfShares = post["numberOfShares"] as? Int,
//                                                let timeStamp = post["timeStamp"] as? NSDate,
                                                let caption = post["caption"] as? String {
                                                
                                                posst.author = author
//                                                posst.numberOfLikes = numberOfLikes
//                                                posst.numberOfComments = numberOfComments
//                                                posst.numberOfShares = numberOfShares
                                                posst.pathToImage = pathToImage
                                                posst.postID = postID
                                                posst.userID = userID
                                                posst.caption = caption
//                                                posst.timeStamp = timeStamp
                                                
                                                self.posts.append(posst)
                                            }
                                        }
                                    }
                                    self.collectionView.reloadData()
                                }
                            }
                        })
                        
                    }
                }
            }
            
        })
        dbRef.removeAllObservers()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        
        cell.postImageView.downloadImage(from: self.posts[indexPath.row].pathToImage)
        cell.authorNameLabel.text = self.posts[indexPath.row].author
//        cell.numberOfLikesLabel.text = "\(self.posts[indexPath.row].numberOfLikes) Likes"
//        cell.authorPhoto.downloadImage(from: user.imagePath!)
        cell.postCaptionLabel.text = self.posts[indexPath.row].caption
        
        return cell
    }

}









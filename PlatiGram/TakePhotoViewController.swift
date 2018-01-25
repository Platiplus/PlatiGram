//
//  TakePhotoViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 23/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Photos

class TakePhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBAction func unwindToSelect(segue:UIStoryboardSegue) {}
    
    
    var imageArray = [UIImage]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        grabPhotos()
        if photoImageView.image == nil {
            photoImageView.image = imageArray[0]
        }
    }    
    
    func grabPhotos(){
        
        let imgManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions){
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: {image, error in
                    
                        self.imageArray.append(image!)
                        
                    })
                }
            }
            
            else {
                print("You Don't Have Any Photos!")
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoImageView.image = imageArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - 1
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoPost" {
            
            let photoPost = segue.destination as! PhotoPostTableViewController
            
            let imagePhoto = photoImageView.image
            photoPost.photo = imagePhoto!
        }
    }
    
}

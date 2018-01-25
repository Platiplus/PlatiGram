//
//  PostCell.swift
//  PlatiGram
//
//  Created by Platiplus on 16/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {

    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
}

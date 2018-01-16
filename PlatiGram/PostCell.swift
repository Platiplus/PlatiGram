//
//  PostCell.swift
//  PlatiGram
//
//  Created by Platiplus on 16/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesButton: UIButton!
    @IBOutlet weak var postCaptionLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!

    
    var post: Post!{
        didSet{
            self.updateUI()
        }
    }
    
    //Função abaixo define o conteúdo da célula do post
    func updateUI(){
        postImageView.image = post.image
        postCaptionLabel.text = post.caption
        numberOfLikesButton.setTitle("Be the first to comment!", for: [])
        timeAgoLabel.text = post.timeAgo
    }
    
}

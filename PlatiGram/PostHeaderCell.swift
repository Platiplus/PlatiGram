//
//  PostHeaderCell.swift
//  PlatiGram
//
//  Created by Platiplus on 11/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var post: Post!{
        didSet{
            self.updateUI()
        }
    }
    
    //Função que define as propriedades da Header
    func updateUI(){
        //Propriedades da Imagem de Perfil
        profileImageView.image = post.createdBy.profileImage
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
        profileImageView.layer.masksToBounds = true
        
        //Propriedades do label do nome do usuário
        usernameLabel.text = post.createdBy.username
        
        //Propriedades do botão de Follow
        //followButton.layer.borderWidth = 1.0
        //followButton.layer.cornerRadius = 2.0
        //followButton.layer.borderColor = followButton.tintColor.cgColor
        //followButton.layer.masksToBounds = true
    }
    
    }

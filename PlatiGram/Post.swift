//
//  Post.swift
//  PlatiGram
//
//  Created by Platiplus on 11/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit

struct Post
{
    var createdBy: User
    var timeAgo: String?
    var caption: String?
    var image: UIImage?
    var numberOfLikes: Int?
    var numberOfComments: Int?
    var numberOfShares: Int?
    
    static func fetchPosts() -> [Post]
    {
        var posts = [Post]()
        
        let plat = User(username: "Platiplus", profileImage: UIImage(named: "plat"))
        
        let post1 = Post(createdBy: plat, timeAgo: "2 hr", caption: "Estrada de Platina", image: UIImage(named: "1"), numberOfLikes: 12, numberOfComments: 5, numberOfShares: 2)
        
        let post2 = Post(createdBy: plat, timeAgo: "3 hrs", caption: "Corredor da Santa Casa de Santos", image: UIImage(named: "2"), numberOfLikes: 8, numberOfComments: 12, numberOfShares: 92)
        
        let post3 = Post(createdBy: plat, timeAgo: "5 hrs", caption: "Sangava", image: UIImage(named: "3"), numberOfLikes: 8, numberOfComments: 92, numberOfShares: 89)
        
        let post7 = Post(createdBy: plat, timeAgo: "2d ago", caption: "Ornitorrinco", image: UIImage(named: "7"), numberOfLikes: 2, numberOfComments: 8, numberOfShares: 9)
        
        let uilha = User(username: "Uilha", profileImage: UIImage(named: "uilha"))
        
        let post4 = Post(createdBy: uilha, timeAgo: "2 hrs", caption: "Ciclovia de Santos", image: UIImage(named: "4"), numberOfLikes: 94, numberOfComments: 8, numberOfShares: 918)
        
        let post5 = Post(createdBy: uilha, timeAgo: "8 hrs", caption: "Praça da Liberdade", image: UIImage(named: "5"), numberOfLikes: 99, numberOfComments: 83, numberOfShares: 89)
        
        let post6 = Post(createdBy: uilha, timeAgo: "Yesterday", caption: "Viagem de Carro", image: UIImage(named: "6"), numberOfLikes: 9, numberOfComments: 82, numberOfShares: 74)
        
        posts.append(post1)
        posts.append(post4)
        posts.append(post2)
        posts.append(post7)
        posts.append(post5)
        posts.append(post3)
        posts.append(post6)
        
        return posts
    }
}




















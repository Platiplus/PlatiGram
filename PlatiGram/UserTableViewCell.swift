//
//  UserTableViewCell.swift
//  PlatiGram
//
//  Created by Platiplus on 18/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Firebase

class UserTableViewCell: UITableViewCell {


    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    
    
    var userID: String!

    
    
    @IBAction func followBtnPressed(_ sender: Any) {
        
        
        
    }
}

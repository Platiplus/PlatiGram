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
    
    @IBAction func followButtonPressed(_ sender: Any) {
        
    }
    
    var userID: String!
    
    func following(status: Bool) {
        
        if status == true {
            followButton.backgroundColor = self.tintColor
            followButton.setTitleColor(.white, for: .normal)
            
        }
        else {
            followButton.backgroundColor = .white
            followButton.setTitleColor(self.tintColor, for: .normal)
        }
    }
}

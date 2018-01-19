//
//  FollowButton.swift
//  PlatiGram
//
//  Created by Platiplus on 18/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit

class FollowButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 2.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = self.tintColor.cgColor
        self.layer.masksToBounds = true	
    }
}

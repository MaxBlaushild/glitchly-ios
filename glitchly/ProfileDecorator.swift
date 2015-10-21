//
//  ProfileDecorator.swift
//  glitchly
//
//  Created by Max Blaushild on 10/20/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class ProfileDecorator: NSObject {
    
    func decorateProfilePicture(profilePic: UIImageView, user: User) {
        if let url = NSURL(string: user.profile_url) {
            if let data = NSData(contentsOfURL: url){
                profilePic.contentMode = UIViewContentMode.ScaleAspectFit
                profilePic.image = UIImage(data: data)
            }
        }
    }
    
    func decorateUsernameLabel(usernameLabel: UILabel, user: User) {
        usernameLabel.text = user.username
    }

}

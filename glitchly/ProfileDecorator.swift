//
//  ProfileDecorator.swift
//  glitchly
//
//  Created by Max Blaushild on 10/20/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class ProfileDecorator: NSObject {
    
    // ask giorgio best practice for this situation
    
    func fetchProfilePicture(user: User) -> UIImage {
        
        let url = NSURL(string: user.profile_url)
        let data = NSData(contentsOfURL: url!)
        return UIImage(data: data!)!

    }

    
    func fetchCollectionCellPicture(picture:Picture) -> UIImage {
        
        let url = NSURL(string: picture.url)
        let data = NSData(contentsOfURL: url!)
        return UIImage(data: data!)!

    }
    

}

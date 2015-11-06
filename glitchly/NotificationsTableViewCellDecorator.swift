//
//  NotificationsTableViewCellDecorator.swift
//  glitchly
//
//  Created by Max Blaushild on 11/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class NotificationsTableViewCellDecorator: NSObject {
    
    func fetchNotificationPicture(pictureURL:String) -> UIImage {
        
        let url = NSURL(string: pictureURL)
        let data = NSData(contentsOfURL: url!)
        return UIImage(data: data!)!
        
    }

}

//
//  FeedPictureDecorator.swift
//  glitchly
//
//  Created by Max Blaushild on 10/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class FeedPictureDecorator: NSObject {
    
    func decorateCell(cell:FeedPictureCell, picture:Picture) {
        
        cell.backgroundColor = UIColor.blackColor()
        cell.picture = picture
        cell.updatePicture()
        cell.updateUserWidget()
        cell.updateComments()
        cell.updateLikes()
        cell.upDateLikeButton()
        
        
    }

}

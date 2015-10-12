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
        
        cell.updateCaption(picture.caption)
        cell.updatePicture(picture.url)
        cell.updateUserWidget(picture.creatorName, user_thumb: picture.creatorThumb, user_id: picture.creatorId)
        
    }

}

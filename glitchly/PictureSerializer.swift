//
//  PictureSerializer.swift
//  glitchly
//
//  Created by Max Blaushild on 10/20/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON

class PictureSerializer: NSObject {
    
    func serializePicture(picture:JSON) -> Picture {
        let newPic = Picture()
        newPic.url = picture["large_url"].string!
        newPic.caption = picture["caption"].string!
        newPic.creatorId = picture["user"]["id"].int!
        newPic.likes = picture["likes"].int!
        newPic.creatorName = picture["user"]["username"].string!
        newPic.likedByUser = picture["liked_by_user"].bool!
        newPic.creatorThumb = picture["user"]["thumb_url"].string!
        newPic.id = picture["id"].int!
        for comment in picture["comments"].array! {
            let newComment = Comment()
            newComment.body = comment["body"].string!
            newComment.id = comment["id"].int!
            newComment.username = comment["user"]["username"].string!
            newComment.user_id = comment["user"]["id"].int!
            newComment.user_thumb = comment["user"]["profile_url"].string!
            newPic.comments.append(newComment)
        }
        return newPic
    }
    
    func serializeUserPicture(picture:JSON) -> Picture {
        let newPic = Picture()
        newPic.url = picture["large_url"].string!
        newPic.caption = picture["caption"].string!
        newPic.id = picture["id"].int!
        return newPic
    }

}

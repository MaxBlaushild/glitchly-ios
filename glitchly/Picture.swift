//
//  Picture.swift
//  glitchly
//
//  Created by Max Blaushild on 10/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON

class Picture: NSObject, IsSerializedFromJSON {

    var id:Int
    var url:String
    var likes:Int
    var caption:String
    var creatorName:String
    var creatorId:Int
    var creatorThumb:String
    var comments:[Comment] = [Comment]()
    var likedByUser:Bool

    required init(json:JSON){
        self.url = json["large_url"].string!
        self.caption = json["caption"].string!
        self.creatorId = json["user"]["id"].int!
        self.likes = json["likes"].int!
        self.creatorName = json["user"]["username"].string!
        self.likedByUser = json["liked_by_user"].bool!
        self.creatorThumb = json["user"]["thumb_url"].string!
        self.id = json["id"].int!
        for comment in json["comments"].array! {
            self.comments.append(Comment(json: comment))
        }
    }

}

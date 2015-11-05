//
//  Comment.swift
//  glitchly
//
//  Created by Max Blaushild on 10/11/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comment: NSObject, IsSerializedFromJSON {
    
    var body:String
    var id:Int
    var username:String
    var user_id:Int
    var user_thumb:String
    
    required init(json:JSON) {
        self.body = json["body"].string!
        self.id = json["id"].int!
        self.username = json["user"]["username"].string!
        self.user_id = json["user"]["id"].int!
        self.user_thumb = json["user"]["profile_url"].string!
    }

}

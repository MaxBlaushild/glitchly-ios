//
//  User.swift
//  glitchly
//
//  Created by Max Blaushild on 10/13/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject, IsSerializedFromJSON {
    
    var username:String
    var email:String
    var profile_url:String
    var thumb_url:String
    var id:Int
    var pictures:[ProfileShowPicture] = [ProfileShowPicture]()
    var followedByUser:Bool
    
    required init(json:JSON){
        self.username = json["username"].string!
        self.email = json["email"].string!
        self.profile_url = json["profile_url"].string!
        self.thumb_url = json["thumb_url"].string!
        self.id = json["id"].int!
        self.followedByUser = json["followed_by_user"].bool!
        for picture in json["pictures"].array! {
            self.pictures.append(ProfileShowPicture(json: picture))
        }
    }
    
    override init(){
        self.username = ""
        self.email = ""
        self.profile_url = ""
        self.thumb_url = ""
        self.id = 0
        self.pictures = [ProfileShowPicture]()
        self.followedByUser = false
    }

}

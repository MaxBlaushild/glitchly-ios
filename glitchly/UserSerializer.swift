//
//  UserSerializer.swift
//  glitchly
//
//  Created by Max Blaushild on 10/20/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserSerializer: NSObject {
    
    func serializerUser(json:JSON) -> User {
        let user = json["user"]
        let newUser:User = User()
        newUser.username = user["username"].string!
        newUser.email = user["email"].string!
        newUser.profile_url = user["profile_url"].string!
        newUser.thumb_url = user["thumb_url"].string!
        newUser.id = user["id"].int!
        return newUser
    }

}

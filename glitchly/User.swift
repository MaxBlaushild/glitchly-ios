//
//  User.swift
//  glitchly
//
//  Created by Max Blaushild on 10/13/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var username:String = ""
    var email:String = ""
    var profile_url:String = ""
    var thumb_url:String = ""
    var id:Int = 0
    var pictures:[Picture] = [Picture]()
    var followedByUser:Bool = false

}

//
//  ProfileShowPicture.swift
//  glitchly
//
//  Created by Max Blaushild on 11/4/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileShowPicture: NSObject, IsSerializedFromJSON {
    
    let url:String
    let caption:String
    let id:Int
    
    required init(json:JSON) {
        self.url = json["large_url"].string!
        self.caption = json["caption"].string!
        self.id = json["id"].int!
    }

}

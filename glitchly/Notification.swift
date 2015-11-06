//
//  Notification.swift
//  glitchly
//
//  Created by Max Blaushild on 11/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import SwiftyJSON

class Notification: NSObject, IsSerializedFromJSON {
    
    var body:String
    var displayPictureURL:String
    var segueId:Int
    var active:Bool
    
    static func constructURL(pictureJSON: JSON) -> String {
        let id = pictureJSON["id"].int!
        let fileName = pictureJSON["image_file_name"].string!
        return "https://s3.amazonaws.com/glitchly/\(id)/\(fileName)"
    }
    
    required init(json:JSON) {
        self.body = json["description"].string!
        self.displayPictureURL = Notification.constructURL(json["picture"])
        self.segueId = json["picture"]["id"].int!
        self.active = json["active"].bool!
    }
}

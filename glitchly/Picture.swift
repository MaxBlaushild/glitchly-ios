//
//  Picture.swift
//  glitchly
//
//  Created by Max Blaushild on 10/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class Picture: NSObject {

    var id: Int = 0
    var url:String = ""
    var likes:Int = 0
    var caption:String = ""
    var creatorName:String = ""
    var creatorId:Int = 0
    var creatorThumb:String = ""
    var comments:[Comment] = []
    var likedByUser:Bool = false


}

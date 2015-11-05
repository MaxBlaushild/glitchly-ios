//
//  IsSerializedFromJSON.swift
//  glitchly
//
//  Created by Max Blaushild on 11/4/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol IsSerializedFromJSON {
    init(json:JSON)
}
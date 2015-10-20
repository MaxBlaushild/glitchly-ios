//
//  LabelDecorator.swift
//  glitchly
//
//  Created by Max Blaushild on 10/13/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class LabelDecorator: NSObject {
    
    func decorateLabels(){
        UILabel.appearance().font = UIFont(name: "VT323", size: 22)
        UILabel.appearance().textColor = UIColor(netHex: 0x0652ff)
    }

}

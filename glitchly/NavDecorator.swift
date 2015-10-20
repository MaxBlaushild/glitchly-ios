//
//  NavDecorator.swift
//  glitchly
//
//  Created by Max Blaushild on 10/13/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class NavDecorator: NSObject {
    
    func decorateNav(nav: UINavigationBar) {
        nav.tintColor = UIColor.whiteColor()
        nav.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "VT323", size: 22)! ]
        nav.barTintColor = UIColor(netHex: 0xFF6600)
    }

}

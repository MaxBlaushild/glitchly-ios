//
//  UIImageViewAsynchronousLoading.swift
//  glitchly
//
//  Created by Max Blaushild on 11/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        Alamofire.request(.GET, urlString).response { (request, response, data, error) in
            self.image = UIImage(data: data!, scale:1)
        }
    }
}

extension UIButton {
    public func imageFromUrl(urlString: String){
        Alamofire.request(.GET, urlString).response { (request, response, data, error) in
            let image = UIImage(data: data!, scale:1)
            self.setBackgroundImage(image, forState: .Normal)
        }
    }
}

//
//  UserSearchTableViewCell.swift
//  glitchly
//
//  Created by Max Blaushild on 11/2/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class UserSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var followOrUnfollowButton: UIButton!

    @IBAction func followOrUnfollow(sender: AnyObject) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

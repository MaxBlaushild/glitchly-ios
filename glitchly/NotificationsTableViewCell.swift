//
//  NotificationsTableViewCell.swift
//  glitchly
//
//  Created by Max Blaushild on 11/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        notificationLabel!.textColor = UIColor.whiteColor()
        notificationLabel!.font = UIFont(name: "VT323", size: 22)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

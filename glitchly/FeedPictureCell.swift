//
//  FeedPictureCell.swift
//  glitchly
//
//  Created by Max Blaushild on 10/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class FeedPictureCell: UITableViewCell {
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // MARK: IRenderSong implementation
    func updateCaption(caption: String) {
        
        captionLabel.text = caption as String
        
    }
    
    func updateUserWidget(username: String, user_thumb: String, user_id: Int){
        
        if let url = NSURL(string: user_thumb) {
            if let data = NSData(contentsOfURL: url){
                userPic.contentMode = UIViewContentMode.ScaleAspectFit
                userPic.image = UIImage(data: data)
            }
        }
        
        userLabel.text = username as String
    }
    
    func updatePicture(sUrl: String) {
        
        if let url = NSURL(string: sUrl) {
            if let data = NSData(contentsOfURL: url){
                pictureView.contentMode = UIViewContentMode.ScaleAspectFit
                pictureView.image = UIImage(data: data)
            }
        }
        
    }

}

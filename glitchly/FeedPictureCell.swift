//
//  FeedPictureCell.swift
//  glitchly
//
//  Created by Max Blaushild on 10/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class FeedPictureCell: UITableViewCell {
    
    @IBOutlet weak var userPic: UIButton!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var topUserLabel: UIButton!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    
    var picture:Picture!
    
    let likeAPIController = LikeAPIController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let doubleTap = UITapGestureRecognizer(target:self, action:Selector("toggleLikeStatus:"))
        doubleTap.numberOfTapsRequired = 2
        pictureView.userInteractionEnabled = true
        pictureView.addGestureRecognizer(doubleTap)
    }
    

    @IBAction func toggleLikeStatus(sender: AnyObject) {
        
        if picture.likedByUser {
            
            likeAPIController.unlikePicture(picture.id)
            picture.likedByUser = !picture.likedByUser
            picture.likes--
            updateLikes()
            upDateLikeButton()
            
        } else {
            
            likeAPIController.likePicture(picture.id)
            picture.likedByUser = !picture.likedByUser
            picture.likes++
            upDateLikeButton()
            updateLikes()
            
        }
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // MARK: IRenderSong implementation
    
    func updateUserWidget(){
        userPic.imageFromUrl(picture.creatorThumb)
        userPic.tag = picture.creatorId
        userPic.frame = CGRectMake(25, 25, 25, 25)
        
        topUserLabel.setTitle(picture.creatorName, forState: .Normal)
        topUserLabel.tag = picture.creatorId
    }
    
    func updateLikes() {
        
        let title:String
        
        if picture.likes == 1 {
            title = "1 like"
        } else {
            title = "\(picture.likes) likes"
        }

       likesButton.setTitle(title, forState: .Normal)
    }
    
    func updateComments() {
        
        let title:String
        let numberOfComments = picture.comments.count
        
        if numberOfComments == 1 {
            title = "1 comment"
        } else {
            title = "\(numberOfComments) comments"
        }
        
        commentsButton.setTitle(title, forState: .Normal)
    }
    
    func updatePicture() {
        
        pictureView.imageFromUrl(picture.url)

    }
    
    func upDateLikeButton(){
        
        if (picture.likedByUser) {
            
            let image = UIImage(named:"red-heart.png")
            likeButton.setImage(image, forState: .Normal)
                
        } else {
            
            let image = UIImage(named:"heart.png")
            likeButton.setImage(image, forState: .Normal)
            
        }
        
    }

}

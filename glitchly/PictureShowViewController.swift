//
//  PictureShowViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 11/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class PictureShowViewController: UITableViewController {
    
    
    let feedPictureDecorator = FeedPictureDecorator()
    let pictureAPIController = PictureAPIController()
    
    //recieved from elsewhere
    var pictureId:Int!
    var picture:Picture!
    var feedAPIController:FeedAPIController!
    var currentUser:User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPictureReceived:", name:"pictureFetched", object: nil)
        
        pictureAPIController.getPicture(pictureId)
        
        self.view.backgroundColor = UIColor.blackColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onPictureReceived(notification:NSNotification){
        
        picture = notification.object as! Picture
        
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedPictureCell", forIndexPath: indexPath) as! FeedPictureCell
        
        if let _ = picture as Picture? {
            feedPictureDecorator.decorateCell(cell, picture: picture)
        }
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "ProfileSegue" {
            if let destinationVC = segue.destinationViewController as? ProfileViewController{
                destinationVC.userId = sender!.tag
                destinationVC.currentUser = currentUser
                destinationVC.feedAPIController = feedAPIController
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

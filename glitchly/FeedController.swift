//
//  FeedControllerTableViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 10/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class FeedController: UITableViewController {
    
    private let feedProvider = FeedProvider()
    private let feedPictureDecorator = FeedPictureDecorator()
    private var feed:[Picture] = []
    private let loginManager = LoginManager()
    private let navDecorator = NavDecorator()
    private let labelDecorator = LabelDecorator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // decorates the navbar
        let nav = self.navigationController?.navigationBar
        navDecorator.decorateNav(nav!)
        
        // decorates the labels
        labelDecorator.decorateLabels()
 
        self.view.backgroundColor = UIColor.blackColor()
        
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: "onFeedReceived:", name:"feedFetched", object: nil)
        defaultCenter.addObserver(self, selector: "onLoginCheck:", name:"loggedIn", object: nil)
        
        loginManager.fetchCurrentUser()
    }
    
    func onLoginCheck(notification: NSNotification){
        
        if (notification.object != nil) {
            
            feedProvider.getFeed()
            
        } else {
            
            createLoginAlert()
            
        }
    }
    
    func onFeedReceived(notification: NSNotification){
        
        feed = notification.object as! [Picture]
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createLoginAlert(){
        
        let loginAlert = LoginAlertViewController(title: "Login", message: "Type your deets.", preferredStyle: .Alert)
        
        loginAlert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Username"
        }
        
        loginAlert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        self.presentViewController(loginAlert, animated: true){
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feed.count
    }
    
    @IBAction func openLoginAlert(sender: AnyObject) {
        createLoginAlert()
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> FeedPictureCell {
        let cell:FeedPictureCell = tableView.dequeueReusableCellWithIdentifier("feedPictureCell", forIndexPath: indexPath) as! FeedPictureCell
        
        feedPictureDecorator.decorateCell(cell, picture: feed[indexPath.row])

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

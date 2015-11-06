//
//  FeedControllerTableViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 10/7/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class FeedController: UITableViewController {
    
    private var feedAPIController:FeedAPIController!
    private let loginService:LoginService = LoginService()
    private let feedPictureDecorator = FeedPictureDecorator()
    private var feed:[Picture] = []
    private var currentUser:User!

    @IBOutlet weak var profileButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: "onFeedReceived:", name:"feedFetched", object: nil)
        defaultCenter.addObserver(self, selector: "onLoginCheck:", name:"loggedIn", object: nil)
        
        loginService.fetchCurrentUser()
    }
    
    func onLoginCheck(notification: NSNotification){
        
        if (notification.object != nil) {
            
            initializeCurrentUser(notification.object as! User)
            initializeFeed()
            
        } else {
            
            createLoginAlert()
            
        }
    }
    
    func initializeFeed(){
        
        feedAPIController = FeedAPIController()
        feedAPIController.getFeed()
        
    }
    
    func initializeCurrentUser(user:User){
        
        currentUser = user
        profileButton.tag = currentUser.id
        
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
        
        let forgotPasswordAction = UIAlertAction(title: "Forgot Password", style: .Destructive) { (_) in }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        let loginAction = UIAlertAction(title: "Login", style: .Default) { (_) in
            let loginTextField = loginAlert.textFields![0] as UITextField
            let passwordTextField = loginAlert.textFields![1] as UITextField
            
            self.loginService.login(loginTextField.text!, password: passwordTextField.text!)
        }
        
        //        loginAction.enabled = false
        
        loginAlert.addAction(loginAction)
        loginAlert.addAction(forgotPasswordAction)
        loginAlert.addAction(cancelAction)
        
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
    
    override func viewWillLayoutSubviews(){
        
        self.view.backgroundColor = UIColor.blackColor()
        
        // decorates the navbar
        let nav = self.navigationController?.navigationBar
        nav!.tintColor = UIColor.whiteColor()
        nav!.barTintColor = UIColor(netHex: 0xFF6600)
        
        
        // decorates the labels
        let labelAppearance = UILabel.appearance()
        labelAppearance.font = UIFont(name: "VT323", size: 22)
//        labelAppearance.textColor = UIColor(netHex: 0x0652ff)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProfileSegue" {
            if let destinationVC = segue.destinationViewController as? ProfileViewController{
                destinationVC.userId = sender!.tag
                destinationVC.currentUser = currentUser
                destinationVC.feedAPIController = feedAPIController
            }
        } else if segue.identifier! == "feedToSearchSegue" {
            if let destinationVC = segue.destinationViewController as? UserSearchTableViewController {
                destinationVC.currentUser = currentUser
                destinationVC.feedAPIController = feedAPIController
            }
        } else if segue.identifier! == "feedToNotificationsSegue" {
            if let destinationVC = segue.destinationViewController as? NotificationsTableViewController {
                destinationVC.currentUser = currentUser
                destinationVC.feedAPIController = feedAPIController
            }
        }
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation


}

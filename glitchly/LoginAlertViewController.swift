//
//  LoginAlertViewController.swift
//  glitchly
//
//  Created by Max Blaushild on 10/6/15.
//  Copyright © 2015 Max Blaushild. All rights reserved.
//

import UIKit

class LoginAlertViewController: UIAlertController {
    
    var loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forgotPasswordAction = UIAlertAction(title: "Forgot Password", style: .Destructive) { (_) in }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        let loginAction = UIAlertAction(title: "Login", style: .Default) { (_) in
            let loginTextField = self.textFields![0] as UITextField
            let passwordTextField = self.textFields![1] as UITextField
            
            self.loginManager.login(loginTextField.text!, password: passwordTextField.text!)
        }
        
//        loginAction.enabled = false
        
        self.addAction(loginAction)
        self.addAction(forgotPasswordAction)
        self.addAction(cancelAction)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

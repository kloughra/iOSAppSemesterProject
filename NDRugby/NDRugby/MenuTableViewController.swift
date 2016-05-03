//
//  MenuTableViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 3/30/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class MenuTableViewController: UITableViewController {
    
    var menu:[String]?;

    override func viewDidLoad() {
        super.viewDidLoad()
        menu = ["History","Roster","Schedule","News & Updates", "Alumni","Share & Comment"]
        //Facebook Login Button
        let fb = FacebookService()
        fb.requestFacebook(){
            (logButton) in
            CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-self.view.frame.size.height/2);
            logButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-self.view.frame.size.height/6);//self.view.center
            self.view.addSubview(logButton)
            
        }
        tableView.scrollEnabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Override to check for Authentication
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        var authorized:Bool = false
        if FBSDKAccessToken.currentAccessToken() != nil{
            authorized = true
        }
        if authorized != true{
            let alert = UIAlertController(title: "Incorrect Credentials", message: "Please login to facebook to access that page!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        return authorized
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rosterSegue"{
            shouldPerformSegueWithIdentifier("rosterSegue", sender: sender)
        }
        if segue.identifier == "newsSegue"{
            shouldPerformSegueWithIdentifier("newsSegue", sender: sender)
        }
        if segue.identifier == "shareSegue"{
            shouldPerformSegueWithIdentifier("shareSegue", sender: sender)
        }
    }
    



}

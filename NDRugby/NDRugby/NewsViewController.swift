//
//  NewsViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/26/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//


import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let fb = FacebookService()
    var username:String?
    //For Authorized Users
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func doneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addNewsButton(sender: AnyObject) {
        shouldPerformSegueWithIdentifier("addSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fb.getUserName(){
            (username) in
            self.username = username
        }
    }
    
    //Override to check for Authentication
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        var authorized:Bool = false
        for name in self.appDelegate.authorized_users{
            if self.username == name{
                authorized = true
            }
        }
        if authorized == true{
            print("Allowed")
            
        }else{
            print("Not Allowed")
            let alert = UIAlertController(title: "Incorrect Credentials", message: "Sorry, you are not authorized to add new stories. Please go share in the Share & Comment feed!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        return authorized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     return 0
     }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
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
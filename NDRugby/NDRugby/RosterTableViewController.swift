//
//  RosterTableViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/11/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class RosterTableViewController: UITableViewController {
    var roster:[Player] = []
    var photos:[PlayerPhoto] = []
    var borPhotos:[PlayerPhoto] = []
    let fb = FacebookService()


    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addButton(sender: UIBarButtonItem) {
        print("Add Button")
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add Player", message: "Enter player information. Click OK to add to Roster", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Enter player name"
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Enter player position"
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Enter player major"
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Enter player hometown"
        })
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Enter player year"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField0 = alert.textFields![0] as UITextField
            print("Text field: \(textField0.text)")
            let textField1 = alert.textFields![1] as UITextField
            print("Text field: \(textField1.text)")
            let textField2 = alert.textFields![2] as UITextField
            print("Text field: \(textField2.text)")
            let textField3 = alert.textFields![3] as UITextField
            print("Text field: \(textField3.text)")
            let textField4 = alert.textFields![4] as UITextField
            print("Text field: \(textField4.text)")
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    @IBOutlet weak var navOutlet: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navOutlet.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(RosterTableViewController.addTapped))
        
        let newPlayer = Player(firstName: "Katie", lastName: "Loughran", hometown: "South Bend, IN", year: "Senior", position: "8", major:"Computer Science")
        roster.append(newPlayer)
        let fb2 = FireBaseService()
        fb2.getRoster(){
            (roster) in
                self.roster = roster
                self.tableView.reloadData()
        }
        
        fb.images(){
            (photos) in
            self.photos = photos
        }
        
        fb.getBecauseOfRugby(){
            (photos) in
            self.borPhotos = photos
        }
        let im:UIImage = fb.getProfPic()!
        newPlayer.photo = im
        //fb.getName()
        
    }
    /*func addTapped()->Void{
        
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return roster.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! RosterTableViewCell
        let name = "\(self.roster[indexPath.row].firstName) \(self.roster[indexPath.row].lastName)"
        cell.playerName.text = name
        
        cell.hometown.text = self.roster[indexPath.row].hometown
            
        for photo in self.borPhotos{
            if let tags = photo.tags{
                for tag in tags{
                    if tag.lowercaseString.rangeOfString(name.lowercaseString) != nil {
                        let im = fb.sourceImage(photo.source)
                        //cell.playerPhoto.image = im//cropToBounds(im!, width: 128, height: 128)
                        let croppedImage: UIImage = ImageUtil.cropToSquare(image: im!)
                        cell.playerPhoto.image = croppedImage
                    }
                }
            }
        }
        

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playerDetailSegue" {
            if let playerDetailViewController = segue.destinationViewController as? PlayerDetailViewController,
                cell = sender as? RosterTableViewCell,
                indexPath = self.tableView.indexPathForCell(cell){
                //Pass console details
                var new_images:[UIImage] = []
                var new_photos:[PlayerPhoto] = []
                let name = "\(roster[indexPath.row].firstName) \(roster[indexPath.row].lastName)"
                for photo in self.photos{
                    if let tags = photo.tags{
                        for tag in tags{
                            if tag.lowercaseString.rangeOfString(name.lowercaseString) != nil {
                                //print("Photo with tag \(name)")
                                new_images.append(fb.sourceImage(photo.source)!)
                                new_photos.append(photo)
                            }
                        }
                    }
                }
                for photo in self.borPhotos{
                    if let tags = photo.tags{
                        for tag in tags{
                            if tag.lowercaseString.rangeOfString(name.lowercaseString) != nil {
                                playerDetailViewController.mainPhoto = photo
                            }
                        }
                    }
                }
                print(roster[indexPath.row].hometown)
                playerDetailViewController.player = self.roster[indexPath.row]
                
                playerDetailViewController.images = new_images
                playerDetailViewController.photos = new_photos
                
            }
        }
    }
    
    

}

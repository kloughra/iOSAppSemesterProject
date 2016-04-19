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

    override func viewDidLoad() {
        super.viewDidLoad()
        let newPlayer = Player(firstName: "Katie", lastName: "Loughran", hometown: "South Bend, IN", year: "Senior", position: "8")
        roster.append(newPlayer)
        let fb = FacebookService()
        let im:UIImage = fb.getProfPic()!
        newPlayer.photo = im
        fb.getName()
        
    }

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
        print(name)
        cell.hometown.text = self.roster[indexPath.row].hometown
        if let image = self.roster[indexPath.row].photo{
            cell.playerPhoto.image = image
        }

        return cell
    }



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

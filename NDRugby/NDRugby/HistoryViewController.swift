//
//  HistoryViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/25/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyText: UITextView!
    @IBOutlet weak var historyImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyText.editable = false
        self.historyImage.contentMode = .ScaleAspectFit
        //self.photoView.contentMode = .ScaleAspectFit
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

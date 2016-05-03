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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//
//  RosterTableViewCell.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/13/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class RosterTableViewCell: UITableViewCell {

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var hometown: UILabel!
    @IBOutlet weak var playerPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

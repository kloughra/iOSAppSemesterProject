//
//  MediaNewsTableViewCell.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/27/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class MediaNewsTableViewCell: UITableViewCell {


    @IBOutlet weak var updateText: UILabel!
    @IBOutlet weak var updateImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

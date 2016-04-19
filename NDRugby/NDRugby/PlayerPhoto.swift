//
//  PlayerPhoto.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/13/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import Foundation
import UIKit

class PlayerPhoto{
    var id:String
    var source:String
    var tags:[String]?
 
    init(id:String,source:String){
        self.id = id
        self.source = source
    }
}
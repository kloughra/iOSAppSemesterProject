//
//  Player.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/11/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import Foundation
import UIKit

class Player{
    var firstName:String
    var lastName:String
    var nickname:String?
    var hometown:String
    var year:String
    var position:String
    var photo:UIImage?
    
    init(firstName:String,lastName:String,hometown:String,year:String,position:String){
        self.firstName = firstName
        self.lastName = lastName
        self.hometown = hometown
        self.year = year
        self.position = position
    }
    
}
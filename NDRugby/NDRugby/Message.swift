//
//  Message.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/5/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import Foundation


class Message{
    
    var text:String;
    var user:String;
    var date:NSDate?;
    var imageURL:String?;
    
    init(text:String,user:String){
        self.text = text;
        self.user = user;
    }
}
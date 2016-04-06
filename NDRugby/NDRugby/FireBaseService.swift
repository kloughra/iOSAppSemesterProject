//
//  FireBaseService.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/5/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import Foundation
import Firebase

class FireBaseService{
    var myRef = Firebase(url:"https://ndwomensrugby.firebaseio.com")
    
    
    func shareMessages(closure: (message:Message) -> Void){
        var mesgs:[Message] = []
        let shareRef = myRef.childByAppendingPath("ShareTable/Messages")
            shareRef.observeEventType(.ChildAdded, withBlock: { message in
                let text:String = message.value.objectForKey("text") as! String
                let user:String = message.key as String
                var imageURL:String?;
                if let image = message.value.objectForKey("imageURL"){
                    imageURL = image as? String
                }
                
                let newMessage = Message(text:text,user:user)
                if let image = imageURL{
                    newMessage.imageURL = image;
                }
                closure(message:newMessage)
                mesgs.append(newMessage);
                }, withCancelBlock: { error in
                    print(error.description)
        })
    }

    func sendMessage(message:Message) -> Void{
        let shareRef = myRef.childByAppendingPath("ShareTable/Messages")
        let jsonMessage = ["text":"\(message.text)","imageURL":""]
        shareRef.updateChildValues(["\(message.user)":jsonMessage])
    }
    
}
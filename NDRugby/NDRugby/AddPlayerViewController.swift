//
//  AddPlayerViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/27/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var years = ["Freshman","Sophomore","Junior","Senior","Grad"]
    var position = [
        "Prop","Hooker","Lock","Flanker","No. 8","Scrum Half",
        "Fly Half","Center","Wing","Full Back"
    ]
    
    var onDataAvailable : ((player: Player) -> ())?
    
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var playerMajor: UITextField!
    @IBOutlet weak var playerHometown: UITextField!
    @IBOutlet weak var positionPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    var playerPosition:String?
    var playerYear:String?
    
    
    
    //ACTION BUTTONS
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButton(sender: AnyObject) {
        var empty:String?
        empty = ""
        //ADD ALERT - CANNOT EXIT WITH EMPTY FIELDS
        if playerName.text! == empty {
            let refreshAlert = UIAlertController(title: "Empty Field", message: "Please enter a name!", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
            
        }else if playerMajor.text! == empty{
            let refreshAlert = UIAlertController(title: "Empty Field", message: "Please enter a major!", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        }else if playerHometown.text! == empty{
            let refreshAlert = UIAlertController(title: "Empty Field", message: "Please enter a hometown!", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        }else{
            let fullNameArr = playerName.text!.characters.split{$0 == " "}.map(String.init)
            let firstName = fullNameArr[0]
            var lastName = ""
            if fullNameArr.count > 1{
                lastName = fullNameArr[1]
            }
            let newPlayer = Player(firstName: firstName, lastName: lastName, hometown: playerHometown.text!, year: playerYear!, position: playerPosition!, major: playerMajor.text!)
            self.onDataAvailable?(player: newPlayer)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //SET UP VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerYear = "Freshman"
        self.playerPosition = "Prop"
        self.positionPicker.delegate = self
        self.yearPicker.delegate = self
        self.positionPicker.tag = 0
        self.yearPicker.tag = 1
        self.playerHometown.delegate = self
        self.playerMajor.delegate = self
        self.playerName.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShareViewController.tapDismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //PICKER VIEW
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return self.position[row]
        } else if pickerView.tag == 1 {
            return self.years[row]
        }
        return ""
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
            
            if pickerView.tag == 0 {
                self.playerPosition = self.position[row]
            } else if pickerView.tag == 1 {
                self.playerYear = self.years[row]
            }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return self.position.count
        } else if pickerView.tag == 1 {
            return self.years.count
        }
        return 1
    }
    
    
    //KeyBoard Functions
    func tapDismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


}

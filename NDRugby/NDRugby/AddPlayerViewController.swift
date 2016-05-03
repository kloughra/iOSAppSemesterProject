//
//  AddPlayerViewController.swift
//  NDRugby
//
//  Created by Katie Loughran on 4/27/16.
//  Copyright © 2016 Katie Loughran. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var years = ["Freshman","Sophomore","Junior","Senior","Grad"]
    var position = [
        "Prop","Hooker","Lock","Flanker","No. 8","Scrum Half",
        "Fly Half","Center","Wing","Full Back"
    ]
    
    @IBOutlet weak var playerName: UITextField!

    @IBOutlet weak var playerMajor: UITextField!
    @IBOutlet weak var positionPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    var playerPosition:String?
    var playerYear:String?
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButton(sender: AnyObject) {
        var empty:String?
        empty = ""
        
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
        }else{
            print(playerName.text!)
            print(playerMajor.text!)
            print(playerPosition!)
            print(playerYear!)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerYear = "Freshman"
        self.playerPosition = "Prop"
        self.positionPicker.delegate = self
        self.yearPicker.delegate = self
        self.positionPicker.tag = 0
        self.yearPicker.tag = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                //print(self.position[row])
                self.playerPosition = self.position[row]
            } else if pickerView.tag == 1 {
                //print(self.years[row])
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

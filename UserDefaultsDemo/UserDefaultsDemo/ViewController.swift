//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by David Mills on 2018-09-05.
//  Copyright © 2018 David Mills. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let numberValue = userDefaults.object(forKey: "number") as? Int ?? 0
        numberLabel.text = String(numberValue)
        numberStepper.value = Double(numberValue)
        
        let boolValue = userDefaults.object(forKey: "bool") as? Bool ?? false
        switcher.isOn = boolValue
    }

    @IBAction func switchChanged(_ sender: Any) {
        let value = switcher.isOn
        userDefaults.set(value, forKey: "bool")
        userDefaults.synchronize()
    }
    
    @IBAction func stepperChanged(_ sender: Any) {
        let value = numberStepper.value
        numberLabel.text = String(value)
        userDefaults.set(value, forKey: "number")
        userDefaults.synchronize()
    }
}


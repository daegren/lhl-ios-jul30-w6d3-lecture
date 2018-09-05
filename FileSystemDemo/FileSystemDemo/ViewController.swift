//
//  ViewController.swift
//  FileSystemDemo
//
//  Created by David Mills on 2018-09-05.
//  Copyright © 2018 David Mills. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    let fileManager = FileManager.default
    let fileName = "demo.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func load(_ sender: Any) {
        do {
            let documentDir = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let filePath = documentDir.appendingPathComponent(fileName)
            
            let value = try String(contentsOf: filePath, encoding: .utf8)
            
            textView.text = value
        } catch {
            print(error)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        do {
            let documentDir = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let filePath = documentDir.appendingPathComponent(fileName)
            
            if let value = textView.text {
                try value.write(to: filePath, atomically: false, encoding: .utf8)
            }
        } catch {
            print(error)
        }
    }
}


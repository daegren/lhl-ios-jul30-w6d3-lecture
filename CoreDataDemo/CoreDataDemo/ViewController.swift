//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by David Mills on 2018-09-05.
//  Copyright © 2018 David Mills. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    var people : [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            people = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }

    @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
                guard let textField = alert.textFields?.first,
                    let nameToSave = textField.text else {
                        return;
            }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
            people.append(person)
        } catch {
            print(error)
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String

        return cell
    }
}


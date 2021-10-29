//
//  SettingsViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 29/10/2021.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    var userEntityFetched = [UserEntity]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var seedTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsersFromDB()

        if let seed = defaults.string(forKey: "seed") {
            seedTextField.text = seed
        }
        
        // Dismissing keyboard when tapping anywhere else on the screen
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func changeSeedPressed(_ sender: UIButton) {
        for user in userEntityFetched {
            if user.isEdited == false {
                context.delete(user)
            }
        }
        
    }
    
}


extension SettingsViewController {
    // Saving users to CoreData
    func saveUsersToDB() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    // Loading users from CoreData
    func loadUsersFromDB() {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            userEntityFetched = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
}

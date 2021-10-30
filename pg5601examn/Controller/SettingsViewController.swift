//
//  SettingsViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 29/10/2021.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    var userManager = UserManager()
    var coreDataManager = CoreDataManager()
    var userEntityFetched = [UserEntity]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var seedTextField: UITextField!
    @IBOutlet weak var loadingSeedSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userManager.delegate = self
        
        userEntityFetched = coreDataManager.loadUsersFromDB(context: context)

        if let seed = defaults.string(forKey: "seed") {
            seedTextField.text = seed
        }
        
        // Dismissing keyboard when tapping anywhere else on the screen
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func changeSeedPressed(_ sender: UIButton) {
        // Starting the spinner
        loadingSeedSpinner.startAnimating()
        loadingSeedSpinner.hidesWhenStopped = true
        
        // Deleting users if they are not edited
        for user in userEntityFetched {
            if user.isEdited == false {
                context.delete(user)
            }
        }
        userEntityFetched.removeAll()
        
        if let newSeed = seedTextField.text {
            userManager.fetchAllUsers(newSeed)
            defaults.set(newSeed, forKey: "seed")
        }
        
        
    }
    
}

extension SettingsViewController: UserManagerDelegate {
    func didUpdateUserList(_ userManager: UserManager, userData: [UserEntity]) {
        DispatchQueue.main.async {
            self.userEntityFetched = userData
            self.coreDataManager.saveUsersToDB(context: self.context)
            self.loadingSeedSpinner.stopAnimating()
        }
    }
    
    func didFailWithError(error: Error) {
        let alert = UIAlertController(title: "Something went wrong", message: "Check your WIFI-connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
            if let seed = self.seedTextField.text {
                self.userManager.fetchAllUsers(seed)
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

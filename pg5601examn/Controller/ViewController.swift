//
//  ViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var userManager = UserManager()
    var userConverter = UserConverter()
    var users = [UserModel]()
    var userEntityArray = [UserEntity]()
    var userEntityFetched = [UserEntity]()
    // Accessing context from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        userTableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        userTableView.delegate = self
        userTableView.dataSource = self
        userManager.delegate = self
        
        // Using UserDefaults to fetch API only the first time the user is opening the app.
        if defaults.bool(forKey: "First Launch") == true {
            print("Second+")
            launchApplication()
        } else {
            loadingSpinner.startAnimating()
            loadingSpinner.hidesWhenStopped = true
            userManager.fetchAllUsers()
            print("First")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        launchApplication()
    }
}


//MARK: - Launch && CoreData
extension ViewController {
    // TODO: Need to fix this to work first time
    func launchApplication() {
        loadUsersFromDB()
        users = userConverter.convertAllToUserModel(from: userEntityFetched)
        print(userEntityFetched.count)
        userTableView.reloadData()
    }
    
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


//MARK: - UserManagerDelegate
extension  ViewController: UserManagerDelegate {
    func didUpdateUserList(_ userManager: UserManager, userData: [UserEntity]) {
        DispatchQueue.main.async {
            self.userEntityArray = userData
            self.saveUsersToDB()
            self.launchApplication()
            self.loadingSpinner.stopAnimating()
            self.defaults.set(true, forKey: "First Launch")
        }
    }
    
    func didFailWithError(error: Error) {
        
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // Returning 100 rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.cellLabel.text = "\(users[indexPath.row].firstName) \(users[indexPath.row].lastName)"
        cell.cellImage.image = users[indexPath.row].picture
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showUserDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserDetailsViewController {
            destination.userId = users[userTableView.indexPathForSelectedRow!.row].id
        }
    }
}

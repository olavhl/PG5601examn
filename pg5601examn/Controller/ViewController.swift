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
    var users = [UserModel]()
    var userEntityArray = [UserEntity]()
    var userEntityFetched = [UserEntity]()
    // Accessing context from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        userTableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        userTableView.delegate = self
        userTableView.dataSource = self
        userManager.delegate = self

        
        loadUsersFromDB()
        print(userEntityFetched.count)
        
        // TODO: Fix my sqlite file, and convert userEntityFetched to UserModel to display the Users
        
        // Using UserDefaults to fetch API only the first time the user is opening the app.
        if defaults.bool(forKey: "First Launch") == true {
            print("Second+")
            defaults.set(true, forKey: "First Launch")
        } else {
            userManager.fetchAllUsers()
            
            print("First")
            defaults.set(true, forKey: "First Launch")
        }
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
//        self.users = userData
        
        DispatchQueue.main.async {
            self.userEntityArray = userData
            self.userTableView.reloadData()
            self.saveUsersToDB()
        }
        
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // Returning 100 rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
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
            destination.user = users[userTableView.indexPathForSelectedRow!.row]
        }
    }
}

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
    
    let coredataManager = CoreDataManager()

    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        userTableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        userTableView.delegate = self
        userTableView.dataSource = self
        userManager.delegate = self
        
        // Setting spinner as background to center it
        userTableView.backgroundView = loadingSpinner
        
        // Using UserDefaults to fetch API only the first time the user is opening the app.
        if defaults.bool(forKey: "First Launch") == true {
            print("Second+")
            launchApplication()
        } else {
            // Starting the spinner
            loadingSpinner.startAnimating()
            loadingSpinner.hidesWhenStopped = true
            defaults.set("ios", forKey: "seed")
            if let seed = defaults.string(forKey: "seed") {
                userManager.fetchAllUsers(seed)
                
            }
            
            print("First")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        launchApplication()
    }
}


//MARK: - Launch && CoreData
extension ViewController {
    func launchApplication() {
        userEntityFetched = coredataManager.loadUsersFromDB(context: context)
        users = userConverter.convertAllToUserModel(from: userEntityFetched)
        print(userEntityFetched.count)
        userTableView.reloadData()
    }
}


//MARK: - UserManagerDelegate
extension  ViewController: UserManagerDelegate {
    func didUpdateUserList(_ userManager: UserManager, userData: [UserEntity]) {
        DispatchQueue.main.async {
            self.userEntityArray = userData
            self.coredataManager.saveUsersToDB(context: self.context)
            self.launchApplication()
            self.loadingSpinner.stopAnimating()
            self.defaults.set(true, forKey: "First Launch")
        }
    }
    
    func didFailWithError(error: Error) {
        let alert = UIAlertController(title: "Something went wrong", message: "Check your WIFI-connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
            if let seed = self.defaults.string(forKey: "seed") {
                self.userManager.fetchAllUsers(seed)
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
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

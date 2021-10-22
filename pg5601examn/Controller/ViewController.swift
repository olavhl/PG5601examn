//
//  ViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import UIKit

class ViewController: UIViewController {
    var userManager = UserManager()
    
    var users = [UserModel]()
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        userTableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        userTableView.delegate = self
        userTableView.dataSource = self
        userManager.delegate = self
        userManager.fetchAllUsers()
    }
    
}

//MARK: - UserManagerDelegate
extension  ViewController: UserManagerDelegate {
    func didUpdateUserList(_ userManager: UserManager, userData: [UserModel]) {
        self.users = userData
        print("DIDRUN")
        DispatchQueue.main.async {
            self.userTableView.reloadData()
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
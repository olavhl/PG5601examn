//
//  UserDetailsViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 21/10/2021.
//

import UIKit
import CoreData

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userDetailsImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var userId: String?
    var user: UserModel?
    var userArrayForMap = [UserModel]()
    var userConverter = UserConverter()
    var userEntityFetched = [UserEntity]()
    // Accessing context from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsersAndUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUsersAndUI()
    }
    
    // Loading users from db and setting values to the fields
    func loadUsersAndUI() {
        loadUserFromDB()
        
        firstNameLabel.text = user?.firstName
        lastNameLabel.text = user?.lastName
        ageLabel.text = user?.age
        birthLabel.text = user?.birthDate
        emailLabel.text = user?.email
        phoneNumberLabel.text = user?.phoneNumber
        cityLabel.text = user?.city
        userDetailsImageView.image = user?.pictureLarge
    }
    
    @IBAction func deleteUserPressed(_ sender: UIButton) {
        // Deleting user from context and saving to DB
        context.delete(userEntityFetched[0])
        saveUsersToDB()
        // Navigating back to the previous controller
        _ = navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - IBAction and prepareForSegue
extension UserDetailsViewController {
    @IBAction func editUserPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showEditUser", sender: self)
    }
    
    @IBAction func showUserInMapClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "showSingleUserInMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditUserViewController {
            destination.user = user
            destination.userEntityFetched = userEntityFetched
        }
        if let destination = segue.destination as? MapViewController {
            if let userForMap = user {
                userArrayForMap.append(userForMap)
                destination.users = userArrayForMap
            }
            
        }
    }
}

//MARK: - CoreData
extension UserDetailsViewController {
    // Loading users from CoreData
    func loadUserFromDB() {
        user = nil
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        // Searching for the User with ID == userId, which is gotten through segue
        request.predicate = NSPredicate(format: "id = %@", userId!)
        do {
            userEntityFetched = try context.fetch(request)
            user = userConverter.convertSingleUserModel(from: userEntityFetched[0])
        } catch {
            print("Error fetching data from context: \(error)")
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
}

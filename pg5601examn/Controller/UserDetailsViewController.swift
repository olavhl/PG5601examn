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
    var userConverter = UserConverter()
    var userEntityFetched = [UserEntity]()
    // Accessing context from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func editUserPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showEditUser", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditUserViewController {
            destination.user = user
        }
    }
    
}

extension UserDetailsViewController {
    // Loading users from CoreData
    func loadUserFromDB() {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        // Searching for the User with ID == userId, which is gotten through segue
        let predicate = NSPredicate(format: "id = %@", userId!)
        request.predicate = predicate
        do {
            userEntityFetched = try context.fetch(request)
            user = userConverter.convertSingleUserModel(from: userEntityFetched[0])
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
}

//
//  UserDetailsViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 21/10/2021.
//

import UIKit
import CoreData

class UserDetailsViewController: UIViewController {
    
    var userId: String?
    var user: UserModel?
    var userArrayForMap = [UserModel]()
    var userConverter = UserConverter()
    var userEntityFetched = [UserEntity]()
    var deletedUsersArray = [String]()
    // Accessing context from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var userDetailsImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cakeImage = "🎂".image()
        let cakeSliceImage = "🍰".image()
        let cupcakeImage = "🧁".image()
        let birthdayImage = "🎉".image()
        
        let birthdayView = UIImageView(image: birthdayImage)
        birthdayView.frame = CGRect(x: 110, y: 110, width: 40, height: 40)
        imageContainer.addSubview(birthdayView)
        
        let cakeView = UIImageView(image: cakeImage)
        cakeView.frame =  CGRect(x: 100, y: 80, width: 50, height: 50)
        view.addSubview(cakeView)
        
//        UIView.animate(withDuration: 4, delay: 0, options: [.curveLinear, .repeat], animations: {
//            cakeView.frame.origin.y = self.view.frame.height - 200
//        }) { _ in
////            UIView.animate(withDuration: 2.5, delay: 0, options: [.curveLinear], animations: {
////                cakeView.frame.origin.y = self.view.frame.height
////                cakeView.frame.size.width -= 49
////                cakeView.frame.size.height -= 49
////            }, completion: nil)
//            UIView.animate(withDuration: 2.5, animations: {
//                cakeView.frame.origin.y = self.view.frame.height
//                cakeView.frame.size.width -= 49
//                cakeView.frame.size.height -= 49
//            })
//        }
        
        UIView.animateKeyframes(withDuration: 6.5, delay: 0, options: .repeat, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 4/6.5) {
                cakeView.frame.origin.y = self.view.frame.height - 200
            }
            UIView.addKeyframe(withRelativeStartTime: 4/6.5, relativeDuration: 2.5/6.5) {
                cakeView.frame.origin.y = self.view.frame.height
                cakeView.frame.size.width -= 49
                cakeView.frame.size.height -= 49
            }
        })
        
        
        // Fetching deletedUsers from UserDefaults
        if let items = defaults.array(forKey: "deletedUsers") as? [String] {
            deletedUsersArray = items
        }
        
        loadUsersAndUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUsersAndUI()
//        print("hasBirthDayThisWeek: \(user?.hasBirthdayWeek)")
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
        // Storing deletedUsers in UserDefaults
        if let deletedUserId = userEntityFetched[0].id {
            deletedUsersArray.append(deletedUserId)
            defaults.set(deletedUsersArray, forKey: "deletedUsers")
        }
        
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

//MARK: - Converting Emoji-strings to images
// Ready documentation to get source
extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

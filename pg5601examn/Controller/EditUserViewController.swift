//
//  EditUserViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 25/10/2021.
//

import UIKit
import CoreData

class EditUserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    var user: UserModel?
    var userEntityFetched = [UserEntity]()
    let userConverter = UserConverter()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegating to be able to use the next-button
        // on the keyboard to go to the next field
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.ageTextField.delegate = self
        self.birthdateTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneTextField.delegate = self
        self.cityTextField.delegate = self
        
        firstNameTextField.text = user?.firstName
        lastNameTextField.text = user?.lastName
        ageTextField.text = user?.age
        birthdateTextField.text = user?.birthDate
        emailTextField.text = user?.email
        phoneTextField.text = user?.phoneNumber
        cityTextField.text = user?.city
        
        // Dismissing keyboard when tapping anywhere else on the screen
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // Saving users to CoreData
    func saveUsersToDB() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    @IBAction func ageTextFieldEditingEnded(_ sender: UITextField) {
        if ageTextField.text != "" {
            if let ageFromField = ageTextField.text {
                user?.age = ageFromField
                birthdateTextField.text = user?.birthDate
            }
        } else {
            ageTextField.text = user?.age
        }
    }
    
    @IBAction func birthTextFieldEditingEnded(_ sender: UITextField) {
        if birthdateTextField.text != "" {
            if let birthdateFromField = birthdateTextField.text {
                user?.birthDate = birthdateFromField
                ageTextField.text = user?.age
            }
        } else {
            birthdateTextField.text = user?.birthDate
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if firstNameTextField.text != user?.firstName, firstNameTextField.text != "" {
            let firstname = firstNameTextField.text!
            user?.firstName = firstname
            userEntityFetched[0].setValue(firstname, forKey: "firstName")
        }
        if lastNameTextField.text != user?.lastName, lastNameTextField.text != "" {
            let lastname = lastNameTextField.text!
            user?.lastName = lastname
            userEntityFetched[0].setValue(lastname, forKey: "lastName")
        }
        if ageTextField.text != user?.age, ageTextField.text != "" {
            // Changing the value of entireBirthdate, which will impact both
            // birthdate and age
            let age = ageTextField.text!
            user?.age = age
            userEntityFetched[0].setValue(age, forKey: "age")
        }
        if birthdateTextField.text != user?.birthDate, birthdateTextField.text != "" {
            let birthdate = birthdateTextField.text!
            user?.birthDate = birthdate
            userEntityFetched[0].setValue(birthdate, forKey: "entireBirthDate")
        }
        if emailTextField.text != user?.email, emailTextField.text != "" {
            let email = emailTextField.text!
            user?.email = email
            userEntityFetched[0].setValue(email, forKey: "email")
        }
        if phoneTextField.text != user?.phoneNumber, phoneTextField.text != "" {
            let phone = phoneTextField.text!
            user?.phoneNumber = phone
            userEntityFetched[0].setValue(phone, forKey: "phoneNumber")
        }
        if cityTextField.text != user?.city, cityTextField.text != "" {
            let city = cityTextField.text!
            user?.city = city
            userEntityFetched[0].setValue(city, forKey: "city")
        }
        
        saveUsersToDB()
        
//        print(user!)
    }
    
}

//MARK: - UITextFieldDelegate
extension EditUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchToNextField(textField)
        return true
    }

    func switchToNextField(_ currentField: UITextField) {
        switch currentField {
        case self.firstNameTextField:
            self.lastNameTextField.becomeFirstResponder()
        case self.lastNameTextField:
            self.ageTextField.becomeFirstResponder()
        case self.ageTextField:
            self.birthdateTextField.becomeFirstResponder()
        case self.birthdateTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.phoneTextField.becomeFirstResponder()
        case self.phoneTextField:
            self.cityTextField.becomeFirstResponder()
        default:
            self.cityTextField.resignFirstResponder()
        }
    }
}

//
//  EditUserViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 25/10/2021.
//

import UIKit

class EditUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    var user: UserModel?
    
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
        
    }
    
    
    
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
    @IBAction func ageTextFieldEditingEnded(_ sender: UITextField) {
        if let ageFromField = ageTextField.text {
            user?.age = ageFromField
            birthdateTextField.text = user?.birthDate
        }
    }
    
    @IBAction func birthTextFieldEditingEnded(_ sender: UITextField) {
        if let birthdateFromField = birthdateTextField.text {
            user?.birthDate = birthdateFromField
            ageTextField.text = user?.age
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if firstNameTextField.text != user?.firstName, firstNameTextField.text != "" {
            user?.firstName = firstNameTextField.text!
        }
        if lastNameTextField.text != user?.lastName, lastNameTextField.text != "" {
            user?.lastName = lastNameTextField.text!
        }
        if ageTextField.text != user?.age, ageTextField.text != "" {
            // Changing the value of entireBirthdate, which will impact both
            // birthdate and age
            user?.age = ageTextField.text!
        }
        if birthdateTextField.text != user?.birthDate, birthdateTextField.text != "" {
            user?.birthDate = birthdateTextField.text!
        }
        if emailTextField.text != user?.email, emailTextField.text != "" {
            user?.email = emailTextField.text!
        }
        if phoneTextField.text != user?.phoneNumber, phoneTextField.text != "" {
            user?.phoneNumber = phoneTextField.text!
        }
        if cityTextField.text != user?.city, cityTextField.text != "" {
            user?.city = cityTextField.text!
        }
        
        print(user!)
    }
    
}

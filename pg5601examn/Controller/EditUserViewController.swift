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
        
        firstNameTextField.placeholder = user?.firstName
        lastNameTextField.placeholder = user?.lastName
        ageTextField.placeholder = user?.age
        birthdateTextField.placeholder = user?.birthDate
        emailTextField.placeholder = user?.email
        phoneTextField.placeholder = user?.phoneNumber
        cityTextField.placeholder = user?.city
        
        
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

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        
    }
    
}

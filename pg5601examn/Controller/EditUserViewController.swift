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
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        print(userEntityFetched[0].isEdited)
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
}

//MARK: - IBActions
extension EditUserViewController {
    @IBAction func ageTextFieldEditingEnded(_ sender: UITextField) {
        if ageTextField.text != "" {
            if let ageFromField = ageTextField.text {
                user?.age = ageFromField
                birthdateTextField.text = user?.birthDate
                userEntityFetched[0].setValue(user?.entireBirthDate, forKey: "entireBirthDate")
                userEntityFetched[0].setValue(true, forKey: "isEdited")
            }
        } else {
            ageTextField.text = user?.age
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if firstNameTextField.text != user?.firstName, firstNameTextField.text != "" {
            let firstname = firstNameTextField.text!
            userEntityFetched[0].setValue(firstname, forKey: "firstName")
            userEntityFetched[0].setValue(true, forKey: "isEdited")
        }
        if lastNameTextField.text != user?.lastName, lastNameTextField.text != "" {
            let lastname = lastNameTextField.text!
            userEntityFetched[0].setValue(lastname, forKey: "lastName")
            userEntityFetched[0].setValue(true, forKey: "isEdited")
        }
        if emailTextField.text != user?.email, emailTextField.text != "" {
            let email = emailTextField.text!
            userEntityFetched[0].setValue(email, forKey: "email")
            userEntityFetched[0].setValue(true, forKey: "isEdited")
        }
        if phoneTextField.text != user?.phoneNumber, phoneTextField.text != "" {
            let phone = phoneTextField.text!
            userEntityFetched[0].setValue(phone, forKey: "phoneNumber")
            userEntityFetched[0].setValue(true, forKey: "isEdited")
        }
        if cityTextField.text != user?.city, cityTextField.text != "" {
            let city = cityTextField.text!
            userEntityFetched[0].setValue(city, forKey: "city")
            userEntityFetched[0].setValue(true, forKey: "isEdited")
        }
        
        saveUsersToDB()
        
        // Navigating back to the previous controller
        _ = navigationController?.popViewController(animated: true)
    }
}

//MARK: - DatePicker
extension EditUserViewController {
    func createDatePicker() {
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.frame.size = CGSize(width: 0, height: 150)
        birthdateTextField.inputView = datePicker
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthdateTextField.text = dateFormatter.string(from: sender.date)
        print(dateFormatter.string(from: sender.date))
        
        if let birthdateFromField = birthdateTextField.text {
            user?.birthDate = dateFormatter.string(from: sender.date)
            ageTextField.text = user?.age
            userEntityFetched[0].setValue(user?.entireBirthDate, forKey: "entireBirthDate")
            userEntityFetched[0].setValue(true, forKey: "isEdited")
        }
    }
}

//MARK: - CoreData
extension EditUserViewController {
    // Saving users to CoreData
    func saveUsersToDB() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
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

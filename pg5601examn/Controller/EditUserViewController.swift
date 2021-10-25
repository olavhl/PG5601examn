//
//  EditUserViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 25/10/2021.
//

import UIKit

class EditUserViewController: UIViewController {

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
        firstNameTextField.placeholder = user?.firstName
        lastNameTextField.placeholder = user?.lastName
        ageTextField.placeholder = user?.age
        birthdateTextField.placeholder = user?.birthDate
        emailTextField.placeholder = user?.email
        phoneTextField.placeholder = user?.phoneNumber
        cityTextField.placeholder = user?.city
        
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
    }
    
}

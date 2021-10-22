//
//  UserDetailsViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 21/10/2021.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userDetailsImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        firstNameLabel.text = user?.firstName
        lastNameLabel.text = user?.lastName
        ageLabel.text = user?.age
        birthLabel.text = user?.birthDate
        emailLabel.text = user?.email
        phoneNumberLabel.text = user?.phoneNumber
        cityLabel.text = user?.city
        
//        userNameLabel.text = user?.birthDate
//        test.text = user?.age
        userDetailsImageView.image = user?.picture
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

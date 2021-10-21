//
//  UserDetailsViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 21/10/2021.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userDetailsImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = user?.firstName
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

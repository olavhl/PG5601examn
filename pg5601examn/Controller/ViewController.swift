//
//  ViewController.swift
//  pg5601examn
//
//  Created by Olav Hartwedt Larsen on 20/10/2021.
//

import UIKit

class ViewController: UIViewController {
    let userManager = UserManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userManager.getUsers()
    }


}


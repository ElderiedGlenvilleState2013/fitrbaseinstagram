//
//  ViewController.swift
//  DogGram
//
//  Created by Elderied McKinney on 1/8/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit
import Firebase 

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signInClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
    
    }
}


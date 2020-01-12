//
//  SettingsViewController.swift
//  DogGram
//
//  Created by McKinney family  on 1/11/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit
import Firebase


class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } catch {
            print(error)
            self.makeAlert(titleInput: "Error", messageInput: error.localizedDescription ?? "Error")
            
            
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String ) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            
                  let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                  
                  alert.addAction(okButton)
                  present(alert, animated: true, completion: nil)
        
    }
 

}

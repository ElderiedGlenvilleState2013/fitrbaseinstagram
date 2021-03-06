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
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                if error != nil {
                     self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                     self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    //self.sendToFirebase()
                }
            }
        }
        
        
    }
    func sendToFirebase() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let firestoreDB = Firestore.firestore()
        var firestoreRef : DocumentReference? = nil
        
        let firestorePost = ["currentUserEmails" : Auth.auth().currentUser?.email , "username" : "","imageUrl": "", "userBio": "" , "currentSportTeam" : "", "following" : false, "followers" : 0] as [String : Any]
        
        firestoreRef = firestoreDB.collection("Profile").addDocument(data: firestorePost, completion: { (error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Errror")
            }
        })
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if  emailText.text != "" && passwordText.text !=  "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (AuthDataResult, error) in
                
                self.sendToFirebase()
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toCreateVC", sender: nil)
                }
            }
        } else {
          makeAlert(titleInput: "Error", messageInput: "Username/password wrong ")
        }
}
    
    func makeAlert(titleInput: String, messageInput: String ) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                  passwordText.backgroundColor = UIColor.red
        emailText.backgroundColor = UIColor.red
                  let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                  
                  alert.addAction(okButton)
                  present(alert, animated: true, completion: nil)
        
    }

}

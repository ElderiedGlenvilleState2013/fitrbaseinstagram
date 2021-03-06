//
//  EditProfileVC.swift
//  DogGram
//
//  Created by Elderied McKinney on 5/26/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit
import Firebase

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameOfSportTeamTextField: UITextField!
    @IBOutlet weak var userBioTextField : UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImg.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImg.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    
     @objc func chooseImage(){
         let pickerController = UIImagePickerController()
         pickerController.delegate = self
         pickerController.sourceType = .photoLibrary
         present(pickerController, animated: true, completion: nil)
         
     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImg.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    func makeAlert(titleInput: String, messageInput: String ) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
               
                     let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                     
                     alert.addAction(okButton)
                     present(alert, animated: true, completion: nil)
           
       }
    
    
    func sendTOFB() {
        let storage = Storage.storage()
              let storageReference = storage.reference()
              
              let mediaFolder = storageReference.child("media")
              
              if let data = profileImg.image?.jpegData(compressionQuality: 0.5) {
                  
                  let uuid = UUID().uuidString
                  
                  
                  let imagereference = mediaFolder.child("\(uuid).jpg")
                  imagereference.putData(data, metadata: nil) { (metaData, error) in
                      if error != nil {
                          self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                      } else {
                          imagereference.downloadURL { (url, error) in
                              
                              if error == nil {
                                  let imageUrl = url?.absoluteString
                                  
                                  //database
                                  let firestoreDatabase = Firestore.firestore()
                                  var firestoreReference : DocumentReference? = nil
                                  
                                firestoreDatabase.collection("test").document().setData(["dogname" : "loop", "age" : 3, "dage" : "42"])
                                firestoreDatabase.collection("test").document().setData(["dogname" : "sloop", "age" : 34, "dage" : "52"])
                                firestoreDatabase.collection("test").document().setData(["dogname" : "floop", "age" : 33, "dage" : "2"])
                                
                                let firestorePost = ["currentUserEmail" : Auth.auth().currentUser?.email,"imageUrl" : imageUrl , "username" : self.usernameTextField.text, "sportteamname" : self.nameOfSportTeamTextField.text, "userBio" :  self.userBioTextField.text, "follow": false ]  as [String : Any]
                                firestoreReference = firestoreDatabase.collection("Profiles").addDocument(data: firestorePost, completion: { (error) in
                                      
                                      if error != nil {
                                          self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                      } else {
                                          
                                          self.profileImg.image = UIImage(named: "select.png")
                                          self.nameOfSportTeamTextField.text = ""
                                        self.usernameTextField.text = ""
                                          self.makeAlert(titleInput: "Upload", messageInput: "your images was uploaded successfully")
                                      }
                                  })
                              }
                          }
                      }
                  }
              }
              
          }
    
    

    @IBAction func saveBtn(_ sender: Any) {
        sendTOFB()
        shouldPerformSegue(withIdentifier: "toFeedVC", sender: nil)
    }

}


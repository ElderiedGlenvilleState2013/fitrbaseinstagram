//
//  ProfileViewController.swift
//  DogGram
//
//  Created by McKinney family  on 6/12/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProfileViewController: UIViewController {

    
    var userNameArray = [String]()
    var userBioArray = [String]()
    var userImageArray = [String]()
    
    var un : String!
    var bio: String!
    var img : String!
    
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var userBioLbl: UILabel!
    @IBOutlet weak var  userImageView: UIImageView!
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        
    }
    
    
    
    func getProfilesFB(){
           let firestoreDB = Firestore.firestore()
           var  indexPath: IndexPath?
        firestoreDB.collection("Profiles").whereField("currentUserEmail", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
               if error != nil {
                   print(error?.localizedDescription)
               } else {
                   if snapshot?.isEmpty != true && snapshot != nil {
                       self.userImageArray.removeAll(keepingCapacity: true)
                       self.userNameArray.removeAll(keepingCapacity: true)
                       self.userBioArray.removeAll(keepingCapacity: true)
                       
                       for docs in snapshot!.documents {
                           if let profileImages = docs.get("imageUrl") as? String {
                               //self.userImageArray.append(profileImages)
                           // self.userImageView.image = UIImage(named: profileImages)
                            self.userImageView.sd_setImage(with: URL(string: profileImages))
                               print(self.userImageArray)
                           }
                        if let username = docs.get("username") as? String {
                                                     self.userNameArray.append(username)
                            self.usernameLbl.text  = username
                            //self.usernameLbl.text = self.userNameArray[indexPath?.row ?? 0]
                                                     print(self.userImageArray)
                                                 }
                        if let userbio = docs.get("userBio") as? String {
                                                     self.userBioArray.append(userbio)
                            self.userBioLbl.text  = userbio
                                                     print(self.userImageArray)
                                                 }
                       }
                       
                   }
               }
           }
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        getProfilesFB()
        // Do any additional setup after loading the view.
    }
    

   

}

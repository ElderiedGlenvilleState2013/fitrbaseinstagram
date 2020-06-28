//
//  SettingsViewController.swift
//  DogGram
//
//  Created by McKinney family  on 1/11/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit
import Firebase


class SettingsViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
 
    
    
    var userImgArrays = [String]()
    let fbDatabase = Firestore.firestore()
    
    @IBOutlet weak var settingsTable : UITableView!
    @IBOutlet weak var settingsCollectionView : UICollectionView!
    var userNameArray = [String]()
    var likePhotsArray = [String]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTable.delegate = self
        settingsTable.dataSource = self
        // Do any additional setup after loading the view.
        settingsCollectionView.delegate = self
        settingsCollectionView.dataSource = self
        getFBData()
        getTopPost()
       
    }
    

    func getFBData(){
        let fbCollection = fbDatabase.collection("Posts").whereField("postedBy", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userImgArrays.removeAll(keepingCapacity: true)
                    
                    
                    for docs in snapshot!.documents {
                        if let imgUrl = docs.get("imageUrl") as? String {
                            self.userImgArrays.append(imgUrl)
                            print(self.userImgArrays)
                        }
                    }
                    
                    self.settingsTable.reloadData()
                    self.settingsCollectionView.reloadData()
                }
            }
        }
        
    }
    
    func getTopPost(){
        let fbCollection = fbDatabase.collection("Posts").whereField("likes", isGreaterThan: 10).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userNameArray.removeAll(keepingCapacity: true)
                    self.likePhotsArray.removeAll(keepingCapacity: true)
                    
                    for docs in snapshot!.documents {
                        if let photoUrl = docs.get("imageUrl") as? String {
                            self.likePhotsArray.append(photoUrl)
                        }
                        
                        if let names = docs.get("postedBy") as? String {
                            self.userNameArray.append(names)
                        }
                    }
                   // self.settingsTable.reloadData()
                    self.settingsCollectionView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return userImgArrays.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = settingsTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! settingsCell
           
          
        cell.settingImageView.sd_setImage(with: URL(string: self.userImgArrays[indexPath.row]))
           
           return cell
           
       }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  likePhotsArray.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         let cell = settingsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SettingCollectionViewCell
            
           
         cell.userImg.sd_setImage(with: URL(string: self.likePhotsArray[indexPath.row]))
        
        cell.userNames.text = userNameArray[indexPath.row]
            
            return cell
     }
    
    @IBAction func profileScreenPressed(_ sender: Any) {
        performSegue(withIdentifier: "toProfileVC", sender: nil)
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

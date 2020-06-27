//
//  FeedViewController.swift
//  DogGram
//
//  Created by McKinney family  on 1/11/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var FeedTableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var profileImagesArray = [String]()
    var documentIdArray = [String]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedTableView.delegate = self
        FeedTableView.dataSource = self

        // Do any additional setup after loading the view.
        getDataFromFirestore()
        getProfilesFB()
    }
    
    func getProfilesFB(){
        let firestoreDB = Firestore.firestore()
        
        firestoreDB.collection("Profiles").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.profileImagesArray.removeAll(keepingCapacity: true)
                    
                    for docs in snapshot!.documents {
                        if let profileImages = docs.get("imageUrl") as? String {
                            self.profileImagesArray.append(profileImages)
                            print(self.profileImagesArray)
                        }
                    }
                    self.FeedTableView.reloadData()
                }
            }
        }
    }
    
    func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
                
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userImageArray.removeAll(keepingCapacity: true)
                    self.likeArray.removeAll(keepingCapacity: true)
                    self.userEmailArray.removeAll(keepingCapacity: true)
                    self.userCommentArray.removeAll(keepingCapacity: true)
                    self.documentIdArray.removeAll(keepingCapacity: true)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        print(documentID)
                        
                        if let postedBy = document.get("postedBy")  as? String {
                            print(postedBy)
                            self.userEmailArray.append(postedBy)
                            
                            
                        }
                        
                        if let postComment = document.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                            
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                            
                        }
                        
                    }
                    
                    self.FeedTableView.reloadData()
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileImagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FeedTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        //cell.userImageView?.image = UIImage(named: "trash.png")
        cell.profileImage.sd_setImage(with: URL(string: self.profileImagesArray[indexPath.row]))
        
        return cell
        
    }

}

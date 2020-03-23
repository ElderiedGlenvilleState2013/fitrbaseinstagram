//
//  CommentVC.swift
//  DogGram
//
//  Created by McKinney family  on 3/18/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit
import Firebase

class CommentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userCommentDoc : String?
    
    

    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        
            getDataFromFirestore()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendBtn(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let firestoreDatabase = Firestore.firestore()
        var firestoreReference : DocumentReference? = nil
        
        let firestorePost = ["commentBy" :  Auth.auth().currentUser?.email!, "postComment" : self.commentTextField.text!, "date" : FieldValue.serverTimestamp(), "likes" :  0]  as [String : Any]
        
        firestoreReference = firestoreDatabase.collection("Comments").addDocument(data: firestorePost, completion: { (error) in
                                       
                                       if error != nil {
                                           self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                       } else {
                                           
                                           self.commentTextField.text = ""
                                           //self.tabBarController?.selectedIndex = 0
                                           self.makeAlert(titleInput: "Post", messageInput: "your comment was uploaded successfully")
                                       }
                                   })
        

    }
    
    func makeAlert(titleInput: String, messageInput: String ) {
             let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                 
                       let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                       
                       alert.addAction(okButton)
                       present(alert, animated: true, completion: nil)
             
         }

    func getDataFromFirestore() {
           let firestoreDatabase = Firestore.firestore()
           
           firestoreDatabase.collection("Comments").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
               if error != nil {
                   print(error?.localizedDescription)
                   
               } else {
                   if snapshot?.isEmpty != true && snapshot != nil {
                       self.userEmailArray.removeAll(keepingCapacity: true)
                       self.userCommentArray.removeAll(keepingCapacity: true)
                       
                       
                       for document in snapshot!.documents {
                        
                           
                           if let postedBy = document.get("commentBy")  as? String {
                               print(postedBy)
                               self.userEmailArray.append(postedBy)
                               
                               
                           }
                           
                           if let postComment = document.get("postComment") as? String {
                               self.userCommentArray.append(postComment)
                           }
                          
                           
                           
                       }
                       
                       self.commentTableView.reloadData()
                   }
               }
           }
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as!  CommentCell
        
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.emailLabel.text = userEmailArray[indexPath.row]
        userCommentDoc = userEmailArray[indexPath.row]
        
        
        return cell
        
    }
  

}

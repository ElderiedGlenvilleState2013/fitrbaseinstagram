//
//  CommentVC.swift
//  DogGram
//
//  Created by McKinney family  on 3/18/20.
//  Copyright © 2020 Elderied McKinney. All rights reserved.
//

import UIKit

class CommentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var userEmailArray = [String]()
    var userCommentArray = [String]()
    
    

    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as!  CommentCell
        
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.emailLabel.text = userEmailArray[indexPath.row]
        
        
        return cell
        
    }
  

}

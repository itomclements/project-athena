//
//  SelectUserTableViewController.swift
//  Project Athena
//
//  Created by Thomas Clements on 30/09/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserTableViewController: UITableViewController {

    var emails : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let userDictionary = snapshot.value as? NSDictionary{
                if let email = userDictionary["email"] as? String{
                    self.emails.append(email)
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }


 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emails.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

 cell.textLabel?.text = emails[indexPath.row]

        return cell
    }
 
}

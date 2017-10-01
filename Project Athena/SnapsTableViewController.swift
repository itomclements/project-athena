//
//  SnapsTableViewController.swift
//  Project Athena
//
//  Created by Thomas Clements on 30/09/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {

    var snaps : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

       if let uid = Auth.auth().currentUser?.uid{
        
        Database.database().reference().child("users").child(uid).child("snaps").observe(.childAdded) { (snapshot) in
                self.snaps.append(snapshot)
                self.tableView.reloadData()
            
            Database.database().reference().child("users").child(uid).child("snaps").observe(.childRemoved, with:{(snapshot) in
                for snap in self.snaps{
                    var index = 0
                    if snapshot.key == snap.key{
                    self.snaps.remove(at: index)
                }
                    index+=1
                }
                self.tableView.reloadData()
            })
            
        }
        }
    }
    
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "snapsToView", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewSnapVC = segue.destination as? ViewSnapViewController{
            if let snapshot = sender as? DataSnapshot{
                viewSnapVC.snapshot = snapshot
        }
    }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return snaps.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath)

        let snap = snaps[indexPath.row]
        
        if let snapDictionary = snap.value as? NSDictionary{
            if let from = snapDictionary["from"] as? String{
            cell.textLabel?.text = from
            }
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

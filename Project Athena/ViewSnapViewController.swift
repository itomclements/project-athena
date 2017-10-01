//
//  ViewSnapViewController.swift
//  Project Athena
//
//  Created by Thomas Clements on 01/10/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snapshot : DataSnapshot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let snapshot = snapshot{
            if let snapDictionary = snapshot.value as? NSDictionary{
                
                if let imageName = snapDictionary["imageName"] as? String{
                    if let imageURL = snapDictionary["imageURL"] as? String{
                        if let message = snapDictionary["message"] as? String{
                            messageLabel.text = message
                            
                            
                        }
                    }
                }
                
            }
            
        }
    }
    
    
    
}

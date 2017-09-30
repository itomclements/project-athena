//
//  ViewController.swift
//  Project Athena
//
//  Created by Thomas Clements on 27/09/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var topButton: UIButton!
    
    @IBOutlet weak var bottomButton: UIButton!
    
    var loginMode = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    
    @IBAction func topTapped(_ sender: Any) {
        
        if let email = emailTextField.text{
            if let password = passwordTextField.text{
                if loginMode{
                    // Login
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error{
                            print(error)
                        } else {
                            print("login success")
                            self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                        }
                    })
                } else {
                    // Sign up
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            print(error)
                            
                        }else {
                            print("sign up success")
                            self.performSegue(withIdentifier: "authToSnaps", sender: nil)
                        }
                    })
                }
            }
        }
        
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if loginMode {
            //Switch to sign up
            topButton.setTitle("Register", for: .normal)
            bottomButton.setTitle("Switch to Login", for: .normal)
            loginMode = false
        } else {
            //Switch to login
            topButton.setTitle("Login", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            loginMode = true
        }
    }
}


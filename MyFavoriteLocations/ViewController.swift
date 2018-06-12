//
//  ViewController.swift
//  MyFavoriteLocations
//
//  Created by Dan DeAngelis on 6/12/18.
//  Copyright © 2018 deangelisLogic. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var actionSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var userLogin:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionSelectorChanged(_ sender: UISegmentedControl) {
        
        userLogin = !userLogin //User has selected register button rather than sign in.
        
        //See what the user is doing
        userLogin = !userLogin
        
        if userLogin {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        //check if sign in or register
        // only if they have entered something in both fields
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            if userLogin {
                //Sign in with Firebase
                
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    if let u = user {
                        //User is found, go to map page
                        self.performSegue(withIdentifier: "goToMainScreen", sender: self)
                    }
                    else {
                        //Error, check error, show error message (user not found)
                    }
                }
            }
            else {
                //register with Firebase
                
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    if let u = user {
                        //User is found, go to map page
                        self.performSegue(withIdentifier: "goToMainScreen", sender: self)
                    }
                    else {
                        //Error, check error, show error message (user not found)
                    }
                }
                
                
            }
        }
     
    }
}


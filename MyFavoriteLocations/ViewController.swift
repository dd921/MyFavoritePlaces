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
    
    var isSignIn:Bool = true

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionSelectorChanged(_ sender: UISegmentedControl) {
        
        isSignIn = !isSignIn //User has selected register button rather than sign in.
        //See what the user is doing
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        loginOrRegisterAction()
    }
    
    @IBAction func logout(_ sender: UIButton) {
        
        //Logout button was pressed
        self.performSegue(withIdentifier: "goToLogout", sender: self)
    }
    @IBAction func goToMapButton(_ sender: UIButton) {
        // Go from main screen to Map Screen
        self.performSegue(withIdentifier: "goToMap", sender: self)
    }
    @IBAction func goToProfile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "mainToProfile", sender: self)
    }
    @IBAction func goToListView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToList", sender: self)
    }
    
    func loginOrRegisterAction() {
        //check if sign in or register, only if they have entered something in both fields

        if let email = emailTextField.text, let password = passwordTextField.text {
            
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in //Sign in with Firebase
                  
                    for place in listOfPlaces {
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users")
                        let currentUser = user?.user.uid
                        let updateUser = usersReference.child(currentUser!)
                        updateUser.setValue(["email": self.emailTextField.text!, "Places":place])
                    
                        print("The user id is \(currentUser)")
                        print(updateUser)
                    }
                    
                    if let u = user {
                        //User is found, go to map page
                        self.performSegue(withIdentifier: "goToMainScreen", sender: self)
                    }
                    else {
                        //Error, check error, show error message (user not found)
                        print("User Not Found")
                    }
                }
            }
            else {
                //register with Firebase
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    if let u = user {
                        //User is found, go to map page
                        
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users")
                        let userID = user?.user.uid
                        let newUserReference = usersReference.child(userID!)
                        newUserReference.setValue(["email": self.emailTextField.text!])
                        print("description : \(newUserReference.description())")
                        
                        self.performSegue(withIdentifier: "goToMainScreen", sender: self)
                    }
                    else {
                        //Error, check error, show error message (user not found)
                        print("Error Creating New User")
                    }
                    
                    
                }
            }
        }
    }
}


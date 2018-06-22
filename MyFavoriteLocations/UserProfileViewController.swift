//
//  UserProfileViewController.swift
//  MyFavoriteLocations
//
//  Created by Dan DeAngelis on 6/20/18.
//  Copyright © 2018 deangelisLogic. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {

   
    @IBOutlet weak var changeTheID: UILabel!
    
    @IBOutlet weak var changeTheEmail: UILabel!
    
    @IBAction func profileToMain(_ sender: UIButton) {
        self.performSegue(withIdentifier: "profileToMain", sender: self)
    }
    
    func updateTheInfo() {
        let user = Auth.auth().currentUser

            let ref = Database.database().reference()
            let usersReference = ref.child("users")
            let userID = user?.uid
            let userEmail = user?.email
            changeTheID.text = userID
            changeTheEmail.text = userEmail
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       updateTheInfo()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

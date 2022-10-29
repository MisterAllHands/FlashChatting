//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            //Logging users based on their email & password that were stored on FireStore, if registered
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    //Redirecting to Chat when successfuly authorized
                    self.performSegue(withIdentifier: Const.logintoChat, sender: self)
                }
            }
        }
    }
}

//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            //Authenticate users with their entered email and password
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    
                //When a user signs up they will be redirected to the chatView
                    self.performSegue(withIdentifier: Const.registerToChat, sender: self)
                }
            }
        }
    }
    
}

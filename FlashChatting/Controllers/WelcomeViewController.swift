//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    //Navigationbar will disapear when the view loads up
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    //NB disapears as soon as a user taps to any of the buttons.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var letterIndex = 0.0
        let titleText = Const.appLabel
        for letter in titleText {
            //Set timer for each letter that appears on the UI
            Timer.scheduledTimer(withTimeInterval: 0.1 * letterIndex, repeats: false) { timer in
                //Gets all letters and appends them in titleLabel
                self.titleLabel.text?.append(letter)
            }
            //Time interval gets multiplied by letterIndex which means it increases interval for each letter. They start appearing subsequently
            letterIndex += 1
        }
    }
}

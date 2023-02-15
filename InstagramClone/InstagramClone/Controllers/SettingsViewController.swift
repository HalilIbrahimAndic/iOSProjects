//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by Halil Ibrahim Andic on 15.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    

}

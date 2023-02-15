//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by Halil Ibrahim Andic on 15.02.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    

}

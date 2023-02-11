//
//  ViewController.swift
//  ArtBook
//
//  Created by Halil Ibrahim Andic on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }


    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
}


//
//  DetailViewController.swift
//  SimpsonBook
//
//  Created by Halil Ibrahim Andic on 11.02.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedSimpson: Simpsons?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedSimpson?.name
        jobLabel.text = selectedSimpson?.job
        imageView.image = selectedSimpson?.image
    }
    

}

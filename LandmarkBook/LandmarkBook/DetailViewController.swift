//
//  DetailViewController.swift
//  LandmarkBook
//
//  Created by Halil Ibrahim Andic on 11.02.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedLandmarkName
        imageView.image = selectedLandmarkImage
    }
    
    

}

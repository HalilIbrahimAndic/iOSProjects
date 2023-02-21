//
//  DetailViewController.swift
//  FlagList
//
//  Created by Halil Ibrahim Andic on 21.02.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagImage: UIImageView!
    var flagName = ""
    var countryName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagImage.layer.borderWidth = 1
        flagImage.layer.borderColor = UIColor.lightGray.cgColor

        flagImage.image = UIImage(named: flagName)
        
        //title = countryName
        navigationItem.title = countryName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    
    @objc func shareTapped() {
        guard let image = flagImage.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Halil Ibrahim Andic on 20.02.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    var selectedNumber = 0
    var totalNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(selectedNumber) of \(totalNumber)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

}

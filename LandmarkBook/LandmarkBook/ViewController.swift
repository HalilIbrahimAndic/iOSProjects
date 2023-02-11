//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Halil Ibrahim Andic on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var chosenName = ""
    var chosenImage = UIImage()
    
    var landmarkNames: [String] = [
    "Colosseum", "Great Wall", "Kremlin", "Taj Mahal", "Ayasofya"
    ]
    
    var landmarkImages: [UIImage] = [
        UIImage(named: "colosseum.jpeg")!,
        UIImage(named: "wall.jpeg")!,
        UIImage(named: "kremlin.jpeg")!,
        UIImage(named: "tajMahal.jpeg")!,
        UIImage(named: "ayasofya.jpeg")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
    }


}

//MARK: - Extensions
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenName = landmarkNames[indexPath.row]
        chosenImage = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedLandmarkName = chosenName
            destinationVC.selectedLandmarkImage = chosenImage
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = landmarkNames[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.landmarkNames.remove(at: indexPath.row)
            self.landmarkImages.remove(at: indexPath.row)
            //self.tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

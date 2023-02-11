//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Halil Ibrahim Andic on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var simpsonArray: [Simpsons] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Simpson Objects
        let homer = Simpsons(name: "Homer Simpson", job: "Nuclear Safety", image: UIImage(named: "homer.jpeg")!)
        let marge = Simpsons(name: "Marge Simpson", job: "HouseWife", image: UIImage(named: "marge.jpeg")!)
        let bart = Simpsons(name: "Bart Simpson", job: "Student", image: UIImage(named: "bart.jpeg")!)
        let lisa = Simpsons(name: "Lisa Simpson", job: "Student", image: UIImage(named: "lisa.jpeg")!)
        
        simpsonArray = [homer, marge, bart, lisa]
    }


}


//MARK: - TableView Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        simpsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = simpsonArray[indexPath.row].name
        
        return cell
    }
    
    
    
}


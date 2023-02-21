//
//  ViewController.swift
//  FlagList
//
//  Created by Halil Ibrahim Andic on 21.02.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags: [String] = []
    var countryName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }

        tableView.separatorStyle = .singleLine
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flags", for: indexPath)
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        
        countryName = (flags[indexPath.row] as NSString).deletingPathExtension
        cell.textLabel?.text = countryName
               
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.flagName = flags[indexPath.row]
            vc.countryName = (flags[indexPath.row] as NSString).deletingPathExtension
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

}


//
//  ViewController.swift
//  ShoppingList
//
//  Created by Halil Ibrahim Andic on 24.02.2023.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteList))
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func deleteList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    func submit(_ item: String) {
        
        shoppingList.insert(item, at: 0)
        
        // place it on top of tableview
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        let attributedString = NSMutableAttributedString(string: selectedCell?.textLabel?.text ?? "")
        
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributedString.length))
        
        selectedCell?.accessoryType = .checkmark
        selectedCell?.textLabel?.attributedText = attributedString
        selectedCell?.textLabel?.textColor = .lightGray
            
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}


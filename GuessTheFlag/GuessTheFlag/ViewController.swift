//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Halil Ibrahim Andic on 20.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries: [String] = []
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france" , "germany" , "ireland" , "italy" , "monaco" , "nigeria" , "poland" , "russia" , "spain" , "uk" , "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()) - \(score)"
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var chosenAnswer = sender.tag
        
        if chosenAnswer == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong. It was: \(countries[chosenAnswer].uppercased())"
            score -= 1
        }
        
        let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Continue", style: .default, handler: askQuestion)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
}


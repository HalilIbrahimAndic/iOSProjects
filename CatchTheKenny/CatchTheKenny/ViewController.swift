//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Halil Ibrahim Andic on 9.02.2023.
//

import UIKit

class ViewController: UIViewController {

    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var k1: UIImageView!
    @IBOutlet weak var k2: UIImageView!
    @IBOutlet weak var k3: UIImageView!
    @IBOutlet weak var k4: UIImageView!
    @IBOutlet weak var k5: UIImageView!
    @IBOutlet weak var k6: UIImageView!
    @IBOutlet weak var k7: UIImageView!
    @IBOutlet weak var k8: UIImageView!
    @IBOutlet weak var k9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        // HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "high")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        // Images
        k1.isUserInteractionEnabled = true
        k2.isUserInteractionEnabled = true
        k3.isUserInteractionEnabled = true
        k4.isUserInteractionEnabled = true
        k5.isUserInteractionEnabled = true
        k6.isUserInteractionEnabled = true
        k7.isUserInteractionEnabled = true
        k8.isUserInteractionEnabled = true
        k9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        k1.addGestureRecognizer(recognizer1)
        k2.addGestureRecognizer(recognizer2)
        k3.addGestureRecognizer(recognizer3)
        k4.addGestureRecognizer(recognizer4)
        k5.addGestureRecognizer(recognizer5)
        k6.addGestureRecognizer(recognizer6)
        k7.addGestureRecognizer(recognizer7)
        k8.addGestureRecognizer(recognizer8)
        k9.addGestureRecognizer(recognizer9)
        
        kennyArray = [k1, k2, k3, k4, k5, k6, k7, k8, k9]
        
        //Timers
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }
}
    

//MARK: - Extension for Selectors
extension ViewController {

    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            // Highscore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "high")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
                
                // replay
                self.score = 0
                self.scoreLabel.text = "Score: 0"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}



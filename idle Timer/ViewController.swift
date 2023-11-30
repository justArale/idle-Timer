//
//  ViewController.swift
//  idle Timer
//
//  Created by Susanne Küchler on 18.01.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var treeThumbnails: [UIImageView]!
    
    @IBOutlet weak var mainTreeImageView: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var startButton: UIButton!
    
   
    
    var currentTree = 1
    var timer: Timer?
    var timePassed = 0
    var grownTrees = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func updateTrees(){
        currentTree += 1
        if let image = UIImage(named: "Tree\(currentTree)"){
            widthConstraint.constant += widthConstraint.constant * 0.55
            UIView.transition(with: mainTreeImageView, duration: 0.5, options: .transitionCrossDissolve) {
                self.mainTreeImageView.image = image
            }
            
        } else if let image = UIImage(named: "Tree1"){
            if grownTrees == 5 {
                resetApp()
            } else {
                treeThumbnails [grownTrees].alpha = 1.0
                grownTrees += 1
                widthConstraint.constant = 100
                mainTreeImageView.image = image
                currentTree = 1
            }
        }
    }
    
    func resetApp(){
        timer?.invalidate()
        currentTree = 1   
        timePassed = 0
        grownTrees = 0
        if let image = UIImage(named: "Tree1"){
            widthConstraint.constant = 100
            mainTreeImageView.image = image
        }
        startButton.setTitle("START", for: .normal)
        for treeImageView in treeThumbnails{
            treeImageView.alpha = 0.4
        }
    }

    
    @objc func updateTime(){
        timePassed += 1
        if timePassed % 2 == 0 {
            updateTrees()
        }
    }
    
    @IBAction func startButtonHandler(_ sender: UIButton) {
        switch startButton.titleLabel?.text{
        case "START":
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startButton.setTitle("STOP", for: .normal)
        case "STOP":
            resetApp()
        default:
            break
        }
        
    }
}


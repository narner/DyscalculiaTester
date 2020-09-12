//
//  GuessDotsQuantityViewController.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/6/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import UIKit

class GuessDotsQuantityViewController: UIViewController {
    
    var numberOfCircles: Int!
    var circles: [CircleView] = []
    var startTime: Double!
    
    @IBOutlet weak var spelledOutNumber: UILabel!
    @IBOutlet weak var numeralNumber: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spelledOutNumber.isHidden = true
        numeralNumber.isHidden = true
        timerLabel.isHidden = true
        
        let singleTap = UITapGestureRecognizer(target: self, action:#selector(self.handleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        self.view.backgroundColor = UIColor.white
        drawCircles()
    }
    
    func drawCircles(){
        for case let circle as CircleView in self.view.subviews {
            circle.removeFromSuperview()
        }
        
        spelledOutNumber.isHidden = true
        numeralNumber.isHidden = true
        timerLabel.isHidden = true
        
        circles.removeAll()
        
        numberOfCircles = Int.random(in: 1..<10)
        let circleWidth = CGFloat(50)
        let circleHeight = circleWidth
        
        var i = 0
        while i < numberOfCircles {
            let circleView = CircleView(frame: CGRect(x: 0.0, y: 0.0, width: circleWidth, height: circleHeight))
            circleView.frame.origin = circleView.frame.randomPoint
            circles.append(circleView)
            print(circles.count)
            for c in circles {
                self.view.addSubview(circleView)
                
                for c in circles {
                    if(c.frame.intersects(circleView.frame)) {
                        //The two views are "overlapping"
                        circleView.frame.origin = circleView.frame.randomPoint
                    }
                    
                    while !UIScreen.main.bounds.contains(circleView.frame.origin) {
                        circleView.frame.origin = CGPoint()
                        circleView.frame.origin = circleView.frame.randomPoint
                    }
                }
                print(c.frame.origin)
            }
            i += 1
        }
        startTime = (NSDate.timeIntervalSinceReferenceDate)
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if spelledOutNumber.isHidden == true && numeralNumber.isHidden == true && timerLabel.isHidden == true {
            spelledOutNumber.isHidden = false
            numeralNumber.isHidden = false
            timerLabel.isHidden = false
            
            spelledOutNumber.text = circles.count.asWord.capitalizingFirstLetter()
            numeralNumber.text = String(circles.count)
            
            let elapsed = NSDate.timeIntervalSinceReferenceDate - startTime
            timerLabel.text = String(String(elapsed).prefix(4)) + " Seconds"
            
        } else {
            drawCircles()
        }
    }
}







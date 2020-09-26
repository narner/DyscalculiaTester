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
    @IBOutlet weak var circlesView: UIView!
    
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
        generateCircles()
    }
    
    func generateCircles(){
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
            circles.append(circleView)
            i += 1
        }
        drawCircles()
    }
    
    func drawCircles(){
        
        for c in circles {
            
            let prev = circles.before(c)
            let after = circles.after(c)

            c.center = getRandomPoint()
             
            if let prev = prev {
                if distance(prev.center, c.center) <= 200 {
                    c.center = getRandomPoint()
                    while distance(prev.center, c.center) <= 200 {
                        c.center = getRandomPoint()
                    }
                    
                }
            }
            
            if let after = after {
                if distance(after.center, c.center) <= 200 {
                    c.center = getRandomPoint()
                    while distance(after.center, c.center) <= 200 {
                        c.center = getRandomPoint()
                    }
                }
            }

            
        }
        
            
        for c in circles {
            self.view.addSubview(c)
        }
                    
        startTime = (NSDate.timeIntervalSinceReferenceDate)
    }
    
    func getRandomPoint() -> CGPoint {
        let viewMidX = self.circlesView.bounds.midX
        let viewMidY = self.circlesView.bounds.midY

        let xPosition = self.circlesView.frame.midX - viewMidX + CGFloat(arc4random_uniform(UInt32(viewMidX*2)))
        let yPosition = self.circlesView.frame.midY - viewMidY + CGFloat(arc4random_uniform(UInt32(viewMidY*2)))
        let point = CGPoint(x: xPosition, y: yPosition)
        return point
    }
    
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
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
            generateCircles()
        }
    }
}






extension BidirectionalCollection where Iterator.Element: Equatable {
    typealias Element = Self.Iterator.Element

    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let lastItem: Bool = (index(after:itemIndex) == endIndex)
            if loop && lastItem {
                return self.first
            } else if lastItem {
                return nil
            } else {
                return self[index(after:itemIndex)]
            }
        }
        return nil
    }

    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop && firstItem {
                return self.last
            } else if firstItem {
                return nil
            } else {
                return self[index(before:itemIndex)]
            }
        }
        return nil
    }
}



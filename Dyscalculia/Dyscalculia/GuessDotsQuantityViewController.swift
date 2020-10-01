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
    
    func generateCircles() {
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
        
        for _ in 0..<numberOfCircles {
            let circleView = CircleView(frame: CGRect(origin: getRandomPoint(), size: (CGSize(width: circleWidth, height: circleHeight))))
                
            
            circles.append(circleView)
        }
        drawCircles()
    }
    
    func drawCircles() {
        for i in 0..<circles.count{
            circles[i].center = getRandomPoint()
            for j in 0..<circles.count{
                if(i != j) {
                    let comparingCentre = circles[j].center
                    let dist = distance(comparingCentre, circles[i].center)
                    if dist <= 50 {
                        
                        var newCenter = circles[i].center
                        var centersVector = CGVector(dx: newCenter.x - comparingCentre.x, dy: newCenter.y - comparingCentre.y)
                     
                        centersVector.dx *= 51 / dist
                        centersVector.dy *= 51 / dist
                        newCenter.x = comparingCentre.x + centersVector.dx
                        newCenter.y = comparingCentre.y + centersVector.dy
                        circles[i].center = newCenter
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
        
        if !validatePoint(point) {
            return getRandomPoint()
        }
        return point
    }

    func validatePoint(_ point: CGPoint) -> Bool {
        for circle in circles {
            if distance(circle.frame.origin, point) <= 50 {
                return false
            }
        }
        return true
    }

    
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(hypot(xDist, yDist))
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


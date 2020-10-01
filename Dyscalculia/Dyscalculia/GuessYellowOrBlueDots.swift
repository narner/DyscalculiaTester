//
//  GuessYellowOrBlueDots.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/30/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import UIKit

class GuessYellowOrBlueDots: UIViewController {

    @IBOutlet weak var circlesView: UIView!

    var numberOfCircles: Int!
    var circles: [CircleView] = []
    @IBOutlet weak var colorLabel: UILabel!

    var yellowCircleCount = 0
    var blueCircleCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black

        let singleTap = UITapGestureRecognizer(target: self, action:#selector(self.handleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)

        colorLabel.isHidden = true
        generateCircles()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        clearCircles()

        if colorLabel.isHidden == true {
            colorLabel.isHidden = false
            checkColorAmmounts()
            return
        }
        if colorLabel.isHidden == false {
            colorLabel.isHidden = true
            generateCircles()
            return
        }
    }
    
    func checkColorAmmounts() {
        if yellowCircleCount > blueCircleCount {
            colorLabel.text = "YELLOW"
            colorLabel.textColor = .yellow
        }
        if blueCircleCount > yellowCircleCount {
            colorLabel.text = "BLUE"
            colorLabel.textColor = .blue
        }
    }
    
    func clearCircles() {
        for case let circle as CircleView in self.view.subviews {
            circle.removeFromSuperview()
        }
        circles.removeAll()
    }
    
    func generateCircles() {
        numberOfCircles = Int.random(in: 1..<50)
        
        let circleWidth = CGFloat(25)
        let circleHeight = circleWidth
        
        for _ in 0..<numberOfCircles {
            let circleView = CircleView(frame: CGRect(origin: getRandomPoint(), size: (CGSize(width: circleWidth, height: circleHeight))))
            let number = Int.random(in: 0..<2)
            if number == 1 {
                circleView.mainColor = .yellow
            } else {
                circleView.mainColor = .blue
            }
            
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
                    if dist <= 25 {
                        
                        var newCenter = circles[i].center
                        var centersVector = CGVector(dx: newCenter.x - comparingCentre.x, dy: newCenter.y - comparingCentre.y)
                     
                        centersVector.dx *= 26 / dist
                        centersVector.dy *= 26 / dist
                        newCenter.x = comparingCentre.x + centersVector.dx
                        newCenter.y = comparingCentre.y + centersVector.dy
                        circles[i].center = newCenter
                    }
                }
            }
        }

        yellowCircleCount = 0
        blueCircleCount = 0

        for c in circles {
            self.view.addSubview(c)
            if c.mainColor == .yellow {
                yellowCircleCount += 1
            }
            if c.mainColor == .blue {
                blueCircleCount += 1
            }
        }
        print("Yellow: ", yellowCircleCount)
        print("Blue: ", blueCircleCount)
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
    
}

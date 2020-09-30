    //
//  CircleView.swift
//  Dyscalculia
//
//  Created by Nick Arner on 9/7/20.
//  Copyright © 2020 nfa. All rights reserved.
//

import UIKit

class CircleView: UIView {
     var mainColor: UIColor = .blue {
         didSet { }
     }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let dotPath = UIBezierPath(ovalIn: rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = dotPath.cgPath
        shapeLayer.fillColor = mainColor.cgColor
        layer.addSublayer(shapeLayer)
    }

}

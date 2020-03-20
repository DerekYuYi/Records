//
//  RectangleLayer.swift
//  YYSComplexLoadingAnimation
//
//  Created by DerekYuYi on 2018/11/1.
//  Copyright © 2018 Wenlemon. All rights reserved.
//

import Foundation
import UIKit

class RectangleLayer: CAShapeLayer {
    
    
    override init() {
        super.init()
        fillColor = Colors.clear.cgColor
        lineWidth = 5.0
        path = rectanglePathFull.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var rectanglePathFull: UIBezierPath {
        let rectanglePath = UIBezierPath()
        rectanglePath.move(to: CGPoint(x: 0.0, y: 100.0))
        rectanglePath.addLine(to: CGPoint(x: 0.0, y: -lineWidth))
        rectanglePath.addLine(to: CGPoint(x: 100.0, y: -lineWidth))
        rectanglePath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        rectanglePath.addLine(to: CGPoint(x: -lineWidth / 2, y: 100.0))
        rectanglePath.close()
        
        return rectanglePath
    }
    
    /// Animation by stroke property
    func animateStrokeWithColor(color: UIColor) {
        strokeColor = color.cgColor
        let strokeAnim = CABasicAnimation(keyPath: "strokeEnd") // ShapeLayer's property
        strokeAnim.fromValue = 0.0
        strokeAnim.toValue = 1.0
        strokeAnim.duration = 0.4
        add(strokeAnim, forKey: nil)
    }
    
}

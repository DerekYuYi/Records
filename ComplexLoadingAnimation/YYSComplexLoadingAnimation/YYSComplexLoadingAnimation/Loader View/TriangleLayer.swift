//
//  TriangleLayer.swift
//  YYSComplexLoadingAnimation
//
//  Created by DerekYuYi on 2018/11/1.
//  Copyright © 2018 Wenlemon. All rights reserved.
//

import Foundation
import UIKit

class TriangleLayer: CAShapeLayer {
    let innerPadding: CGFloat = 30.0
    
    override init() {
        super.init()
        fillColor = Colors.red.cgColor
        strokeColor = Colors.red.cgColor
        lineWidth = 7.0
        lineCap = CAShapeLayerLineCap.round
        lineJoin = CAShapeLayerLineJoin.round
        path = trianglePathSmall.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var trianglePathSmall: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0 + innerPadding, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95.0 - innerPadding, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    
    var trianglePathLeftExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathRightExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathTopExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5))
        trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    func animate() {
        // 1. left
        let triangleLeft = CABasicAnimation(keyPath: "path")
        triangleLeft.fromValue = trianglePathSmall.cgPath
        triangleLeft.toValue = trianglePathLeftExtension.cgPath
        triangleLeft.beginTime = 0.0
        triangleLeft.duration = 0.3
        
        // 2. right
        let triangleRight = CABasicAnimation(keyPath: "path")
        triangleRight.fromValue = trianglePathLeftExtension.cgPath
        triangleRight.toValue = trianglePathRightExtension.cgPath
        triangleRight.beginTime = triangleLeft.beginTime + triangleLeft.duration
        triangleRight.duration = 0.25
        
        
        // 3. top
        let triangleTop = CABasicAnimation(keyPath: "path")
        triangleTop.fromValue = trianglePathRightExtension.cgPath
        triangleTop.toValue = trianglePathTopExtension.cgPath
        triangleTop.beginTime = triangleRight.beginTime + triangleRight.duration
        triangleTop.duration = 0.20
        
        
        //. group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [triangleLeft, triangleRight, triangleTop]
        groupAnimation.duration = triangleTop.beginTime + triangleTop.duration
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false
        
        add(groupAnimation, forKey: nil)
    }
    
}

//
//  ArcLayer.swift
//  YYSComplexLoadingAnimation
//
//  Created by DerekYuYi on 2018/11/1.
//  Copyright © 2018 Wenlemon. All rights reserved.
//

import Foundation
import UIKit

class ArcLayer: CAShapeLayer {
    let animationDuration: CFTimeInterval = 0.18
    
    override init() {
        super.init()
        fillColor = Colors.blue.cgColor
        path = arcPathStarting.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var arcPathPre: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 99.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 99.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        
        arcPath.close()
        return arcPath
    }
    
    var arcPathStarting: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 80.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 80.0), controlPoint1: CGPoint(x: 30.0, y: 70.0), controlPoint2: CGPoint(x: 40.0, y: 90.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        
        return arcPath
    }
    
    var arcPathLow: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 60.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 60.0), controlPoint1: CGPoint(x: 30.0, y: 65.0), controlPoint2: CGPoint(x: 40.0, y: 50.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathMid: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 40.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 40.0), controlPoint1: CGPoint(x: 30.0, y: 30.0), controlPoint2: CGPoint(x: 40.0, y: 50.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathHigh: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 20.0))
        arcPath.addCurve(to: CGPoint(x: 100.0, y: 20.0), controlPoint1: CGPoint(x: 30.0, y: 25.0), controlPoint2: CGPoint(x: 40.0, y: 10.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    var arcPathComplete: UIBezierPath {
        let arcPath = UIBezierPath()
        arcPath.move(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: -5.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: -5.0))
        arcPath.addLine(to: CGPoint(x: 100.0, y: 100.0))
        arcPath.addLine(to: CGPoint(x: 0.0, y: 100.0))
        arcPath.close()
        return arcPath
    }
    
    /// fill animation: water filling up a glass. (往杯子里倒水的动画)
    func animate() {
        let arcAnimationPre = CABasicAnimation(keyPath: "path")
        arcAnimationPre.fromValue = arcPathPre.cgPath
        arcAnimationPre.toValue = arcPathStarting.cgPath
        arcAnimationPre.beginTime = 0.0
        arcAnimationPre.duration = animationDuration
        
        let arcAnimationLow = CABasicAnimation(keyPath: "path")
        arcAnimationLow.fromValue = arcPathStarting.cgPath
        arcAnimationLow.toValue = arcPathLow.cgPath
        arcAnimationLow.beginTime = arcAnimationPre.beginTime + arcAnimationPre.duration
        arcAnimationLow.duration = animationDuration
        
        let arcAnimationMid = CABasicAnimation(keyPath: "path")
        arcAnimationMid.fromValue = arcPathLow.cgPath
        arcAnimationMid.toValue = arcPathMid.cgPath
        arcAnimationMid.beginTime = arcAnimationLow.beginTime + arcAnimationLow.duration
        arcAnimationMid.duration = animationDuration
        
        let arcAnimationHigh = CABasicAnimation(keyPath: "path")
        arcAnimationHigh.fromValue = arcPathMid.cgPath
        arcAnimationHigh.toValue = arcPathHigh.cgPath
        arcAnimationHigh.beginTime = arcAnimationMid.beginTime + arcAnimationMid.duration
        arcAnimationHigh.duration = animationDuration
        
        let arcAnimationComplete = CABasicAnimation(keyPath: "path")
        arcAnimationComplete.fromValue = arcPathHigh.cgPath
        arcAnimationComplete.toValue = arcPathComplete.cgPath
        arcAnimationComplete.beginTime = arcAnimationHigh.beginTime + arcAnimationHigh.duration
        arcAnimationComplete.duration = animationDuration
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [arcAnimationPre, arcAnimationLow, arcAnimationMid, arcAnimationHigh, arcAnimationComplete]
        groupAnim.duration = arcAnimationComplete.beginTime + arcAnimationComplete.duration
        groupAnim.fillMode = .forwards
        groupAnim.isRemovedOnCompletion = false
        
        add(groupAnim, forKey: nil)
    }
    
}

//
//  OvalLayer.swift
//  YYSComplexLoadingAnimation
//
//  Created by DerekYuYi on 2018/11/1.
//  Copyright © 2018 Wenlemon. All rights reserved.
//

import Foundation
import UIKit

class OvarLayer: CAShapeLayer {
    let animationDuration: CFTimeInterval = 0.3
    
    override init() {
        super.init()
        fillColor = Colors.red.cgColor
        path = ovalPathSmall.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var ovalPathSmall: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 50.0, y: 50.0, width: 0, height: 0))
    }
    
    var ovalPathLarge: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 2.5, y: 17.5, width: 95.0, height: 95.0))
    }
    
    var overPathSquishVertical: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 2.5, y: 20.0, width: 95.0, height: 90.0))
    }
    
    var ovalPathSquishHorizontal: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 5.0, y: 20.0, width: 90.0, height: 90.0))
    }
    
    
    func expand() { // 扩大
        let expandAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = ovalPathSmall.cgPath
        expandAnimation.toValue = ovalPathLarge.cgPath
        expandAnimation.duration = animationDuration
        expandAnimation.fillMode = .forwards
        expandAnimation.isRemovedOnCompletion = false
        add(expandAnimation, forKey: nil)
    }
    
    func wobble() { // 摇晃
        
        // set up sub animations
        let wobble1 = CABasicAnimation(keyPath: "path")
        wobble1.fromValue = ovalPathLarge.cgPath
        wobble1.toValue = overPathSquishVertical.cgPath
        wobble1.beginTime = 0.0
        wobble1.duration = animationDuration
        
        let wobble2 = CABasicAnimation(keyPath: "path")
        wobble2.fromValue = overPathSquishVertical.cgPath
        wobble2.toValue = ovalPathSquishHorizontal.cgPath
        wobble2.beginTime = wobble1.beginTime + wobble1.duration
        wobble1.duration = animationDuration
        
        let wobble3 = CABasicAnimation(keyPath: "path")
        wobble3.fromValue = ovalPathSquishHorizontal.cgPath
        wobble3.toValue = overPathSquishVertical.cgPath
        wobble3.beginTime = wobble2.beginTime + wobble2.duration
        wobble3.duration = animationDuration
        
        let wobble4 = CABasicAnimation(keyPath: "path")
        wobble4.fromValue = overPathSquishVertical.cgPath
        wobble4.toValue = ovalPathLarge.cgPath
        wobble4.beginTime = wobble3.beginTime + wobble3.duration
        wobble4.duration = animationDuration
        
        // setup group animation
        let wobbleGroup = CAAnimationGroup()
        wobbleGroup.animations = [wobble1, wobble2, wobble3, wobble4]
        wobbleGroup.duration = wobble4.beginTime + wobble4.duration
        wobbleGroup.repeatCount = 2
        
        // add animation
        add(wobbleGroup, forKey: nil)
    }
    
    func contract() { // 收缩
        let contractAnim = CABasicAnimation(keyPath: "path")
        contractAnim.fromValue = ovalPathLarge.cgPath
        contractAnim.toValue = ovalPathSmall.cgPath
        contractAnim.duration = animationDuration
        contractAnim.fillMode = .forwards
        contractAnim.isRemovedOnCompletion = false
        add(contractAnim, forKey: nil)
    }
    
    
    
}

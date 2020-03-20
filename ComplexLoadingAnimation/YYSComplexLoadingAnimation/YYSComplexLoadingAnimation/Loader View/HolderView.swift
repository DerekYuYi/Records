//
//  HolderView.swift
//  YYSComplexLoadingAnimation
//
//  Created by DerekYuYi on 2018/11/2.
//  Copyright © 2018 Wenlemon. All rights reserved.
//

import UIKit

protocol HolderViewDelegate: AnyObject {
    func animateLabel()
}

class HolderView: UIView {
    
    let ovalLayer = OvarLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let arcLayer = ArcLayer()
    
    var parentFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    weak var delegate: HolderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
        addOval()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
        
        // excute wobbleOval method duration 0.3
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(wobbleOval), userInfo: nil, repeats: false)
    }
    
    @objc func wobbleOval() {
        layer.addSublayer(triangleLayer)
        ovalLayer.wobble()
        
        // excute drawAnimatedTriangle method duration 0.9
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(drawAnimatedTriangle), userInfo: nil, repeats: false)
    }

    @objc func drawAnimatedTriangle() {
        triangleLayer.animate()
        
        // excute spinAndTransform method duration 0.9
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(spinAndTransform), userInfo: nil, repeats: false)
    }
    
    @objc func spinAndTransform() {
        // 1. set anchor point
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.6)
        
        // 2. rotation animation
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.toValue = CGFloat.pi * 2.0
        rotationAnim.duration = 0.45
        rotationAnim.isRemovedOnCompletion = true
        
        layer.add(rotationAnim, forKey: nil)
        
        // 3. contract
        ovalLayer.contract()
        
        // 4. draw rectangle enclosure
        Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(drawRedAnimatedRectangle), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(drawBlueAnimatedRectangle), userInfo: nil, repeats: false)
    }
    
    @objc func drawRedAnimatedRectangle() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.animateStrokeWithColor(color: Colors.red)
    }
    
    @objc func drawBlueAnimatedRectangle() {
        // 1. draw blue animated rectangle
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.animateStrokeWithColor(color: Colors.blue)
        
        // 2. draw acr
        Timer.scheduledTimer(timeInterval: 0.40, target: self, selector: #selector(drawArc), userInfo: nil, repeats: false)
    }
    
    @objc func drawArc() {
        
        // 1. draw arc and fills up the container
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        
        // 2. excute expand animation duration 0.90
        Timer.scheduledTimer(timeInterval: 0.90, target: self, selector: #selector(expandView), userInfo: nil
            , repeats: false)
    }
    
    @objc func expandView() {
        // 1. 颜色为矩形的填充色
        backgroundColor = Colors.blue
        
        // 2. set frame
        frame = CGRect(x: frame.origin.x - blueRectangleLayer.lineWidth,
                       y: frame.origin.y - blueRectangleLayer.lineWidth,
                       width: frame.size.width + blueRectangleLayer.lineWidth * 2,
                       height: frame.size.height + blueRectangleLayer.lineWidth * 2)
        
        // 3. all sublayers are removed
        layer.sublayers = nil
        
        // 4. an animation is added to expand the HolderView to fill the screen
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame = self.parentFrame
        }) { finished in
            self.addLabel()
        }
    }
    
    func addLabel() {
        delegate?.animateLabel()
    }
    
    

}

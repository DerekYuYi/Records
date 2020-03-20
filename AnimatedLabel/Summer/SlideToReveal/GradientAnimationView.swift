//
//  GradientAnimationView.swift
//  Summer
//
//  Created by DerekYuYi on 2018/9/7.
//  Copyright © 2018年 Summer. All rights reserved.
//

import UIKit

class GradientAnimationView: UIView {
    internal var text: String? = nil {
        didSet {
            setNeedsDisplay()
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let attributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 16.0), NSAttributedStringKey.paragraphStyle: style]
            
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
            if let text = text as NSString? {
                text.draw(in: self.bounds, withAttributes: attributes)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                let maskLayer = CALayer()
                maskLayer.backgroundColor = UIColor.clear.cgColor
                maskLayer.frame = self.bounds.offsetBy(dx: self.bounds.width, dy: 0)
                maskLayer.contents = [image?.cgImage]
                gradientLayer.mask = maskLayer
            }
        }
    }
    
    var gradientLayer: CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.backgroundColor = UIColor.yellow.cgColor
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
//        let colors = [UIColor.black.cgColor,
//                      UIColor.white.cgColor,
//                      UIColor.black.cgColor]
//        let locations: [NSNumber] = [0.25, 0.5, 0.75]
        
        let colors = [UIColor.yellow.cgColor,
                      UIColor.green.cgColor,
                      UIColor.orange.cgColor,
                      UIColor.cyan.cgColor,
                      UIColor.red.cgColor,
                      UIColor.yellow.cgColor]
 
        let locations: [NSNumber] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        
        gradient.colors = colors
        gradient.locations = locations
        
        return gradient
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: -bounds.width, y: 0, width: bounds.width*3.0, height: bounds.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.addSublayer(gradientLayer)
        let basicAnim = CABasicAnimation(keyPath: "locations")
        basicAnim.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
        basicAnim.toValue = [0.65, 0.8, 0.85, 0.9, 0.95, 1.0]
        
        basicAnim.duration = 2.0
        basicAnim.repeatCount = 3
        gradientLayer.add(basicAnim, forKey: "")
    }
    
}

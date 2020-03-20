//
//  DWHollowLabel.swift
//  Summer
//
//  Created by DerekYuYi on 2018/8/29.
//  Copyright © 2018年 Summer. All rights reserved.
//

import UIKit

class DWHollowLabel: UILabel {
    
    var fillColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textColor = .white
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.drawText(in: rect)
        
        let context = UIGraphicsGetCurrentContext()
        defer {
            context?.restoreGState()
        }
        guard let image = context?.makeImage() else { return }
        guard let dataProvider = image.dataProvider,
            let imageMask = CGImage(maskWidth: image.width, height: image.height, bitsPerComponent: image.bitsPerComponent, bitsPerPixel: image.bitsPerPixel, bytesPerRow: image.bytesPerRow, provider: dataProvider, decode: image.decode, shouldInterpolate: true) else { return }
        
        context?.saveGState()
        
        context?.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: rect.height))
        context?.clear(rect)
        context?.clip(to: rect, mask: imageMask)
        context?.setFillColor(fillColor.cgColor)
        context?.fill(bounds)
    }
    
}

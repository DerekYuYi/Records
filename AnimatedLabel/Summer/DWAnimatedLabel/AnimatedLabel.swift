//
//  AnimatedLabel.swift
//  Summer
//
//  Created by DerekYuYi on 2018/8/29.
//  Copyright © 2018年 Summer. All rights reserved.
//

import UIKit

public enum DWAnimationType {
    case none, typewriter, shine, fade, wave
}

class AnimatedLabel: UILabel {
    
    // MARK: - Public Properties
    var animationType = DWAnimationType.none {
        didSet {
            _animator = DWAnimator(animationType: animationType, duration: _duration)
            _animator?.label = self
        }
    }
    
    override var text: String? {
        didSet {
            _animator?.label = self
        }
    }
    
    var placeHolderColor: UIColor?
    
//    private fileprivate internal open
    
    // MARK: - Private Properties
    private(set) var placeHolderView: UIView?
    private var _duration: TimeInterval = 4.0
    private var _hollowLabel: DWHollowLabel?
    private var _animator: DWAnimator?
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Start Animation
    func startAnimation(duration: TimeInterval, nextText: String? = nil, completion:(() -> Void)?) {
        guard let animator = _animator else { return }
        if text == nil && nextText == nil {
            return
        } else if nextText != nil {
            text = nextText
        }
        
        if animationType == .wave {
            placeHolderView = UIView(frame: bounds)
            if let placeHolderView = placeHolderView {
                placeHolderView.backgroundColor = placeHolderColor ?? .lightGray
                placeHolderView.layer.masksToBounds = true
                addSubview(placeHolderView)
            }
            
            _hollowLabel = DWHollowLabel(frame: bounds)
            if let hollowLabel = _hollowLabel {
                hollowLabel.text = text
                hollowLabel.textAlignment = textAlignment
                hollowLabel.font = font
                hollowLabel.fillColor = backgroundColor ?? .white
                addSubview(hollowLabel)
            }
        }
        
        _duration = duration
        animator.duration = duration
        animator.label = self
        animator.startAnimation(completion)
    }
    
    
    
}

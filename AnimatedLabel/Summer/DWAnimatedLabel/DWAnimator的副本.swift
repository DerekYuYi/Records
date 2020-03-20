//
//  DWAnimator.swift
//  Summer
//
//  Created by DerekYuYi on 2018/8/29.
//  Copyright © 2018年 Summer. All rights reserved.
//

/**
 - 作用: 管理 AnimatedLabel 的核心动画生命周期
 - 特点: 使用 CADisplayLink 来管理
 **/

import UIKit

class DWAnimator: NSObject {
    // MARK: - Public Properties
    
    var duration: TimeInterval = 2.0
    weak var label: AnimatedLabel? {
        didSet {
            guard let text = label?.text else { return }
            setupAnimatedText(from: text)
        }
    }
    
    // MARK: - Private Properties
    private var animationType: DWAnimationType
    private var _shapeLayer: CAShapeLayer?
    private var _zoom: Double?
    private var _translate: Double?
    private var _waveHeight: Double = 0
    private var _reverse = false
    
    private var _displayLink: CADisplayLink?
    
    private var _beginTime: CFTimeInterval?
    private var _endTime: CFTimeInterval?
    private var _attributedString: NSMutableAttributedString?
    private var _characterAnimationDuration: [TimeInterval]?
    private var _characterAnimationDelay: [TimeInterval]?
    
    private var _completion: (() -> Void)?
    private var _isAnimating: Bool = false
    
    
    // MARK: - Init
    override init() {
        animationType = .none
        super.init()
    }
    
    convenience init(animationType: DWAnimationType, duration: TimeInterval) {
        self.init()
        self.animationType = animationType
        self.duration = duration
    }
    
    // MARK: - Public methods
    func startAnimation(_ completion:(() -> Void)?) {
        guard let label = self.label else { return }
        setup()
        label.layer.removeAllAnimations()
        
        if !_isAnimating {
            _completion = completion
            _beginTime = CACurrentMediaTime()
            if let beginTime = _beginTime {
                _endTime = duration + beginTime
            }
            _displayLink?.isPaused = false
        }
        _isAnimating = true
    }
}

// MARK: - Private methods
/// Setup
extension DWAnimator {
    private func setup() {
        _displayLink = CADisplayLink(target: self, selector: #selector(update))
        _displayLink?.isPaused = true
        _displayLink?.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    private func setupAnimatedText(from labelText: String?) {
        _characterAnimationDelay?.removeAll()
        _characterAnimationDuration?.removeAll()
        
        guard let label = label, let labelText = labelText else { return }
        
        let attributedString = NSMutableAttributedString(string: labelText)
        var durationArray = [TimeInterval]()
        var delayArray = [TimeInterval]()
        
        switch animationType {
        case .typewriter:
            attributedString.addAttribute(.baselineOffset, value: -label.font.lineHeight, range: NSRange(location: 0, length: attributedString.length))
            let displayInternal = duration / TimeInterval(attributedString.length)
            for index in 0..<attributedString.length {
                durationArray.append(displayInternal)
                delayArray.append(TimeInterval(index) * displayInternal)
            }
            
        case .shine:
            attributedString.addAttribute(.foregroundColor, value: label.textColor.withAlphaComponent(0), range: NSRange(location: 0, length: attributedString.length))
            for index in 0..<attributedString.length {
                delayArray.append(TimeInterval(arc4random_uniform(UInt32(duration) / 2 * 100) / 100))
                let remain = duration - Double(delayArray[index])
                durationArray.append(TimeInterval(arc4random_uniform(UInt32(remain) * 100) / 100))
            }
            
        case .fade:
            attributedString.addAttribute(.foregroundColor, value: label.textColor.withAlphaComponent(0), range: NSRange(location: 0, length: attributedString.length))
            let displayInterval = duration / TimeInterval(attributedString.length)
            for index in 0..<attributedString.length {
                delayArray.append(TimeInterval(index) * displayInterval)
                durationArray.append(duration - delayArray[index])
            }
            
        case .wave:
            _zoom = 1
            _translate = 0
            _waveHeight = Double((label.bounds.size.height + label.font.lineHeight) / 2)
            _shapeLayer = CAShapeLayer()
            if let shapeLayer = _shapeLayer {
                
                shapeLayer.path = wavePath()
                shapeLayer.fillColor = label.textColor.cgColor
                shapeLayer.lineWidth = 0.1
                shapeLayer.strokeColor = UIColor.clear.cgColor
                
                if let placeHolderView = label.placeHolderView {
                    placeHolderView.layer.addSublayer(shapeLayer)
                }
            }
            
        default:
            break
        }
        
        _attributedString = attributedString
        _characterAnimationDuration = durationArray
        _characterAnimationDelay = delayArray
        label.attributedText = attributedString
    }
    
    private func wavePath() -> CGPath? {
        guard let label = label else {
            return nil
        }
        
        let originY = (label.bounds.size.height + label.font.lineHeight) / 2
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: _waveHeight))
        var yPosition = 0.0
        if let zoom = _zoom, let translate = _translate {
            for xPosition in 0..<Int(label.bounds.size.width) {
                yPosition = zoom * sin(Double(xPosition) / 180.0 * Double.pi - 4 * translate / Double.pi) * 5 + _waveHeight
                path.addLine(to: CGPoint(x: Double(xPosition), y: yPosition))
            }
            path.addLine(to: CGPoint(x: label.bounds.size.width, y: originY))
            path.addLine(to: CGPoint(x: 0, y: originY))
            path.addLine(to: CGPoint(x: 0, y: _waveHeight))
            path.close()
        }
        return path.cgPath
    }
}


extension DWAnimator {
    @objc private func update() {
        guard let endTime = _endTime, let label = label else { return }
        print("CADisplayLink update")
        let now  = CACurrentMediaTime()
        label.attributedText = transform(currentTime: now)
        if now >= endTime { // cancel
            _displayLink?.isPaused = true
            _displayLink?.invalidate()
            _isAnimating = false
            if let completion = _completion {
                completion()
            }
        }
    }
    
    private func transform(currentTime: CFTimeInterval) -> NSAttributedString? {
        guard let beginTime = _beginTime, let attributedString = _attributedString else { return nil }
        
        switch animationType {
        case .typewriter:
            guard let durationArray = _characterAnimationDuration,
                let delayArray = _characterAnimationDelay,
                let label = label else { return nil }
            
            for index in 0..<attributedString.length {
                
                if CharacterSet.whitespacesAndNewlines.contains(attributedString.string[String.Index(encodedOffset: index)].unicodeScalars.first!) {
                    continue
                }
                attributedString.enumerateAttribute(.baselineOffset, in: NSRange(location: index, length: 1), options: .longestEffectiveRangeNotRequired) { (value, range, stop) in
                    var percent = (CGFloat(currentTime - beginTime) - CGFloat(delayArray[index])) / CGFloat(durationArray[index])
                    percent = fmax(0.0, percent)
                    percent = fmin(1.0, percent)
                    attributedString.addAttribute(.baselineOffset, value: (percent - 1) * label.font.lineHeight, range: range)
                }
            }
            
        case .shine:
            guard let durationArray = _characterAnimationDuration,
                let delayArray = _characterAnimationDelay,
                let label = label else { return nil }
            for index in 0..<attributedString.length {
                if CharacterSet.whitespacesAndNewlines.contains(attributedString.string[String.Index(encodedOffset: index)].unicodeScalars.first!) {
                    continue
                }
                
                attributedString.enumerateAttribute(.foregroundColor, in: NSRange(location: index, length: 1), options: .longestEffectiveRangeNotRequired) { (value, range, stop) in
                    guard let color = value as? UIColor else { return }
                    let alpha = color.cgColor.alpha
                    let shouldUpdate: Bool = (alpha > 0 && alpha < 1) || Float(currentTime - beginTime) >= Float(delayArray[index])
                    if !shouldUpdate {
                        return
                    }
                    let percent = (CGFloat(currentTime - beginTime) - CGFloat(delayArray[index])) / CGFloat(durationArray[index])
                    attributedString.addAttribute(.foregroundColor, value: label.textColor.withAlphaComponent(percent), range: range)
                }
            }
            
        case .fade:
            guard let durationArray = _characterAnimationDuration,
                let delayArray = _characterAnimationDelay,
                let label = label else { return nil }
            for index in 0..<attributedString.length {
                if CharacterSet.whitespacesAndNewlines.contains(attributedString.string[String.Index(encodedOffset: index)].unicodeScalars.first!) {
                    continue
                }
                
                attributedString.enumerateAttribute(.foregroundColor, in: NSRange(location: index, length: 1), options: .longestEffectiveRangeNotRequired) { (value, range, stop) in
                    guard let color = value as? UIColor else {
                        return
                    }
                    let alpha = color.cgColor.alpha
                    let shouldUpdate: Bool = (alpha > 0 && alpha < 1) || Float(currentTime - beginTime) >= Float(delayArray[index])
                    if !shouldUpdate {
                        return
                    }
                    let percent = (CGFloat(currentTime - beginTime) - CGFloat(delayArray[index])) / CGFloat(durationArray[index])
                    attributedString.addAttribute(.foregroundColor, value: label.textColor.withAlphaComponent(percent), range: range)
                }
            }
            
        case .wave:
            guard let shapeLayer = _shapeLayer else {
                return nil
            }
            _waveHeight -= Double(label!.bounds.size.height - label!.font.lineHeight) / (60 / Double(_displayLink!.frameInterval))
            _translate! += 0.1
            if !_reverse {
                _zoom! += 0.02
                if _zoom! >= 1.2 {
                    _reverse = true
                }
            } else {
                _zoom! -= 0.02
                if _zoom! <= 1.0 {
                    _reverse = false
                }
            }
            shapeLayer.path = wavePath()
            
        default:
            break
        }
        return attributedString
    }
}

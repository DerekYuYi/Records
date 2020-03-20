//
//  ViewController.swift
//  YYSComplexLoadingAnimation
//
//  Created by DerekYuYi on 2018/11/1.
//  Copyright © 2018 Wenlemon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HolderViewDelegate {
    
    var holderView = HolderView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                                  y: view.bounds.height / 2 - boxSize / 2,
                                  width: boxSize,
                                  height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        
        view.addSubview(holderView)
    }

    
    // MARK: - HolderViewDelegate
    func animateLabel() {
        // 1. setup
        holderView.removeFromSuperview()
        view.backgroundColor = Colors.blue
        
        // 2. create label
        let label = UILabel(frame: view.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 170.0)
        label.textAlignment = .center
        label.text = "S"
        label.transform = CGAffineTransform(scaleX: 0.25, y: 0.25) // setup scale is squarter
        view.addSubview(label)
        
        // 3. Apply a spring animation to the label to scale it in.
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            label.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
        }) { finished in
            self.addButton()
        }
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        view.backgroundColor = Colors.white
        _ = view.subviews.map({ $0.removeFromSuperview() })
        holderView = HolderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        addHolderView()
    }
}


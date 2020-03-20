//
//  VisualEffectViewPage.swift
//  Summer
//
//  Created by DerekYuYi on 2018/9/17.
//  Copyright © 2018年 Summer. All rights reserved.
//

import UIKit

class VisualEffectViewPage: UIViewController {
    
    let effectView = UIVisualEffectView(effect: nil)
    let labelEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.effectView.effect = nil
        
        label.text = "这, 就是灌篮/n这, 就是灌篮这, 就是灌篮这, 就是灌篮这, 就是灌篮这, 就是灌篮这, 就是灌篮这, 就是灌篮这, 就是灌篮"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24.0)
//        label.backgroundColor = .white
        label.isHidden = true
        label.addSubview(labelEffectView)
        view.addSubview(label)
        effectView.contentView.addSubview(label)
        
        view.addSubview(effectView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        effectView.frame = view.bounds
//        label.frame = CGRect(x: 16.0, y: 100.0, width: effectView.bounds.width-16.0*2, height: 164.0)
        label.frame = CGRect(x: 0, y: 0, width: effectView.bounds.width / 4, height: 40)
        label.center = effectView.center
//        labelEffectView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        labelEffectView.frame = label.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let blurEffect = UIBlurEffect(style: .light)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.effectView.effect = blurEffect
        }) { isFinish in
            UIView.animate(withDuration: 1.5, delay: 0.3, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.label.isHidden = false
                self.label.transform = CGAffineTransform(scaleX: 3, y: 4)
            }, completion: { isFinish in
                self.labelEffectView.effect = nil
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

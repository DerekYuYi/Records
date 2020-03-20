//
//  ViewController.swift
//  Summer
//
//  Created by yuyi on 2017/9/21.
//  Copyright © 2017年 Summer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gradientLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let animView = GradientAnimationView(frame: CGRect(x: 16, y: self.view.bounds.height-64, width: self.view.bounds.width - 16*2, height: 44))
        animView.backgroundColor = .red
        animView.text = "Slide to reveal"
        view.addSubview(animView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


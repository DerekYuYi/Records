//
//  DisplayLinkViewController.swift
//  Summer
//
//  Created by DerekYuYi on 2018/8/29.
//  Copyright © 2018年 Summer. All rights reserved.
//

import UIKit

class DisplayLinkViewController: UIViewController {
    
    var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "CADisplayLink 动画特效"
        // Do any additional setup after loading the view.
        
        waveAnimation()
        /*
        // 1. typewriter
        let label = AnimatedLabel(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width-20, height: 60))
        label.text = "这是打字机的的效果."
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.sizeToFit()
        label.animationType = .typewriter
        label.backgroundColor = UIColor.black
        label.textColor = .white
        view.addSubview(label)
        label.startAnimation(duration: 4.0, nextText: label.text, completion: nil)

        // 2. shine
        let labelShine = AnimatedLabel(frame: CGRect(x: 10, y: 190, width: UIScreen.main.bounds.width-20, height: 70))
        labelShine.text = "这是淡入淡出效果 - shine."
        labelShine.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        labelShine.animationType = .shine
        labelShine.backgroundColor = UIColor.black
        labelShine.textColor = .white
        view.addSubview(labelShine)
        labelShine.startAnimation(duration: 7.0, nextText: labelShine.text, completion: nil)
        
        // 3. fade
        let labelFade = AnimatedLabel(frame: CGRect(x: 10, y: 290, width: UIScreen.main.bounds.width-20, height: 70))
        labelFade.text = "这是渐现的效果,效果很不错哦"
//        labelFade.sizeToFit()
        labelFade.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        labelFade.animationType = .fade
        labelFade.backgroundColor = UIColor.black
        labelFade.textColor = .white
        view.addSubview(labelFade)
        labelFade.startAnimation(duration: 6.0, nextText: labelFade.text, completion: nil)
        */
        
        // 4. wave
        let labelWave = AnimatedLabel(frame: CGRect(x: 10, y: 390, width: UIScreen.main.bounds.width-20, height: 100))
        labelWave.text = "ZhuanYu" // Why can't display Chinese?
//        label.text = "以AZ.A..F"
        labelWave.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        labelWave.animationType = .wave
        labelWave.placeHolderColor = .gray
        labelWave.backgroundColor = .black
        labelWave.textColor = . white
        
        view.addSubview(labelWave)
        view.backgroundColor = .black
        labelWave.startAnimation(duration: 8.0, completion: nil)
        
//        let labelWave = AnimatedLabel(frame: CGRect(x: 10, y: 390, width: UIScreen.main.bounds.width-20, height: 100))
////        labelWave.text = "正在加载"
//        labelWave.text = "LOADING.."
//        labelWave.font = UIFont.systemFont(ofSize: 50, weight: .bold)
//        labelWave.animationType = .wave
//        labelWave.backgroundColor = UIColor.black
//        labelWave.placeHolderColor = .gray
//        labelWave.textColor = .white
//        view.addSubview(labelWave)
////        labelWave.startAnimation(duration: 8.0, nextText: labelWave.text, completion: nil)
//        labelWave.startAnimation(duration: 8.0, completion: nil)
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func waveAnimation() {
        let myView = UIView(frame: CGRect(x: 10, y: 100, width: 50, height: 50))
        myView.backgroundColor = UIColor.cyan
        view.addSubview(myView)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 60  // 60 seconds
        animation.isAdditive = true // Make the animation position values that we later generate relative values.
        
        // From x = 0 to x = 299, generate the y values using sine.
        animation.values = (0..<300).map({ (x: Int) -> NSValue in
            let xPos = CGFloat(x)
            let yPos = sin(xPos)
            
            let point = CGPoint(x: xPos, y: yPos * 10)  // The 10 is to give it some amplitude.
            return NSValue(cgPoint: point)
        })
        myView.layer.add(animation, forKey: "basic")
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

//
//  ShinePage.swift
//  Summer
//
//  Created by DerekYuYi on 2018/8/31.
//  Copyright © 2018年 Summer. All rights reserved.
//

import UIKit

class ShinePage: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    @IBOutlet weak var shineLabel: ShineLabel!
    
    private let textArray = ["For something this complicated, it’s really hard to design products by focus groups. A lot of times, people don’t know what they want until you show it to them.",
                             "We’re just enthusiastic about what we do.",
                             "We made the buttons on the screen look so good you’ll want to lick them."]
    private var textIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstImageView.image = UIImage(named: "wallpaper1")
        secondImageView.image = UIImage(named: "wallpaper2")
        secondImageView.alpha = 0
        shineLabel.text = textArray[textIndex]
        shineLabel.textColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shineLabel.shine()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if shineLabel.visible {
            shineLabel.fadeOutWithCompletion {[weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.changeText()
                
                UIView.animate(withDuration: 2.5, animations: {
                    if strongSelf.firstImageView.alpha > 0.1 {
                        strongSelf.firstImageView.alpha = 0
                        strongSelf.secondImageView.alpha = 1
                    } else {
                        strongSelf.firstImageView.alpha = 1
                        strongSelf.secondImageView.alpha = 0
                    }
                })
                
                strongSelf.shineLabel.shine()
            }
        } else {
            shineLabel.shine()
        }
    }
    
    func changeText() {
        textIndex += 1
        shineLabel.text = textArray[textIndex % self.textArray.count]
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

//
//  ViewController.swift
//  SiriShortcuts
//
//  Created by DerekYuYi on 2019/1/24.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupIntents()
    }
    
    func setupIntents() {
        // 用户中心类
        let activity = NSUserActivity(activityType: "com.Summer.SiriShortcuts.sayHi")
        activity.title = "Say Hi"
        activity.userInfo = ["speech": "hi"]
        activity.isEligibleForSearch = true // 允许搜索
        activity.isEligibleForPrediction = true // siri 应用建议
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier("com.Summer.SiriShortcuts.sayHi")
        view.userActivity = activity
        activity.becomeCurrent() // 在当前设备被激活, 打开 `设置` -> `Siriy与搜索` -> `我的捷径` 中可以找到z该 App 名称
    }
    
    func sayHi() {
        let alert = UIAlertController(title: "Hi There!", message: "Hey there! Glad to see you got this working!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}


//
//  DeviceInfo.swift
//  Summer
//
//  Created by yuyi on 2017/9/21.
//  Copyright © 2017年 Summer. All rights reserved.
//

import UIKit

class DeviceInfo: NSObject {
    var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    var systemName: String {
        return UIDevice.current.systemName
    }
    var deviceModel: String {
        return UIDevice.current.model
    }
    
    var identifierForVerdor: UUID? {
        return UIDevice.current.identifierForVendor
    }
    let infoDictionary = Bundle.main.infoDictionary
    
    func appRelatedInfo() {
        
        guard let infoDictionary = self.infoDictionary else { return }
        if let appVersion = infoDictionary["CFBundleShortVersionString"] as? String {
            print("\(appVersion)")
        }
        
        if let appBuildVersion = infoDictionary["CFBundleVersion"] as? String {
            print("\(appBuildVersion)")
        }
        
        if let appName = infoDictionary["CFBundleDisplayName"] as? String {
            print("\(appName)")
        }
    }
    
}

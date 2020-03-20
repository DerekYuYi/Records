//
//  AppDelegate.m
//  TestLocalPushOniOS10
//
//  Created by DerekYuYi on 2019/2/14.
//  Copyright © 2019 Wenlemon. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 6. Handle local notification
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 请求获取通知权限（角标，声音，弹框）
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 获取用户是否同意开启通知
                NSLog(@"request authorization successed!");
                center.delegate = self;
            }
        }];
        
    } else {
        // register local notification
        if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [application registerUserNotificationSettings:settings];
        }
        
        // receive and handle local notification
        if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
            NSLog(@"Receive local notification after app launching.");
        }
    }
    
    [self triggerLocalNotification];
    
    return YES;
}

#pragma mark - notification
// Notification before iOS10
- (void)triggerLocalNotification {
    if (@available(iOS 10.0, *)) {
        //第二步：新建通知内容对象
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10通知";
        content.subtitle = @"新通知学习笔记";
        content.body = @"新通知变化很大，之前本地通知和远程推送是两个类，现在合成一个了。这是一条测试通知，";
        content.badge = @1;
        UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
        content.sound = sound;
        content.categoryIdentifier = @"";
        content.launchImageName = @"ab.png";
        content.userInfo = @{@"hello": @"how are you", @"msg": @"success"};
        
        //第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
        UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
        
        //第四步：创建UNNotificationRequest通知请求对象
        NSString *requertIdentifier = @"RequestIdentifier";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
        
        //第五步：将通知加到通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"Error:%@",error);
            
        }];
        
    } else {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        
        // 10 s 后发出通知
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        
        localNotification.alertBody = @"本地推送的内容";
        
        localNotification.hasAction = YES;
        localNotification.alertAction = @"测试文字"; // lock screen 本地通知
        
        localNotification.alertLaunchImage = @"sunny_green.png";
        
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        localNotification.applicationIconBadgeNumber = 1;
        
        localNotification.userInfo = @{@"hello": @"how are you", @"msg": @"success"};
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

// receive notification
// 1. application is foreground or background
// 2. application is resign active, and need launch.

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"收到了本地通知");
    //    notification.applicationIconBadgeNumber--; // Why can't modify badge number?
}


// presentation when app is active
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)) {
    completionHandler(UNNotificationPresentationOptionAlert);
}

// presentation when app has resign active (invoke when tapped the notification)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)) {
    completionHandler();
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

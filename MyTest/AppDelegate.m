//
//  AppDelegate.m
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/10.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
///Users/heyz1/Desktop/LeanMessageDemo

#import "AppDelegate.h"
#import "ViewController.h"
#import "ActivityView.h"
#import "ChatView.h"
#import "ScheduleView.h"
#import "MessageVIew.h"
#import "PersonView.h"
#import "ChatContent.h"
#import "DetailActivityView.h"
#define AppID @"Ygyg3RclwgWadDivtgE6SQrv"
#define AppKey @"k5bzTQMCIEzYlywwUo3Rqo8B"
@interface AppDelegate ()
@property(retain,nonatomic) AVIMClient *client;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AVOSCloud setApplicationId:AppID clientKey:AppKey];
    //DetailActivityView *dd=[[DetailActivityView alloc]init];
    //self.window.rootViewController=dd;
//    ChatContent *chat=[ChatContent new];
//    self.window.rootViewController=chat;
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        NSLog(@"%@",currentUser.username);
        ActivityView *av = [[ActivityView alloc]init];
        av.tabBarItem.title=@"活动";
        ChatView *cv = [[ChatView alloc]init];
        cv.tabBarItem.title=@"聊天";
        cv.tabBarItem.badgeValue=@"3";
        ScheduleView *sv = [[ScheduleView alloc]init];
        sv.tabBarItem.title=@"日程";
        MessageVIew *mv = [[MessageVIew alloc]init];
        mv.tabBarItem.title=@"消息";
        mv.tabBarItem.badgeValue=@"3";
        PersonView *pv = [[PersonView alloc]init];
        pv.tabBarItem.title=@"个人";
        UITabBarController *tab = [[UITabBarController alloc]init];
        tab.viewControllers=@[av,cv,sv,mv,pv];
        self.window.rootViewController=tab;
    }
    
        
     return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

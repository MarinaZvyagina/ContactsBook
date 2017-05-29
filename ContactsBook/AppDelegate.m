//
//  AppDelegate.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AppDelegate.h"
#import "CBAPathFileJsonDataBase.h"
#import "VKVMainViewController.h"
#import "CBAFaceBookViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    ViewController *vc = [[ViewController alloc] initWithContactManager:[CBAPathFileJsonDataBase new]];
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    window.rootViewController = nc;
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    return handled;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

@end

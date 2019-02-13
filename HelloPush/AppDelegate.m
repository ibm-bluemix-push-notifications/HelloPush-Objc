//
//  AppDelegate.m
//  HelloPush
//
//  Created by Anantha Krishnan K G on 12/02/19.
//  Copyright © 2019 Ananth. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

static BMSPushBinder* bmsPushBinder = nil;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    bmsPushBinder = [BMSPushBinder sharedInstance];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [bmsPushBinder registerForPushWithDeviceToken:deviceToken userId:@"myUserId" completionHandler:^(NSString * response, NSNumber * statusCode, NSString * error) {
        
        if (error != nil) {
            
            NSLog(@"Registration Error, %@", error);
        } else {
            NSLog(@"Registration Success , %@", response);
        }
    }];
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"Registration Error, %@", error.debugDescription);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"Recieved Notification , %@", userInfo.debugDescription);
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Recieved Notification , %@", userInfo.debugDescription);
}

@end

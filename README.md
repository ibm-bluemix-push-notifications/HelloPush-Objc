# HelloPush-Objc

Sample written in Objective using Swift SDK for IBM Cloud push service


## Requirements
- Xcode 10+
- Swift 4.+
- push service 

## Setup

### Configure Service
 Create a push service and configure for iOS notification - follow this [doc](https://cloud.ibm.com/docs/services/mobilepush/push_step_2.html#enable-push-ios-notifications)

###  Configure app

 1. Create a pod file by running `pod init` in your projects root folder
 2. run `pod install`
 3. open the `projectName.xcworkspace` in Xcode
 4. Create a `.swift` file named `BMSPushBinder`. This will create a `Bridging-Header` file too.
 5. Copy paste the code from `HelloPush/BMSPushBinder.swift` to your `BMSPushBinder.swift` file
 6. Once the swift class is added , you will be able to access the push functions from any objective class.
 7. Dont forget to add  `#import "HelloPush-Swift.h"` and `@class BMSPushBinder;` in the `.h` header files.


### Using the push methods

#### Initialize

  Initialize push service with options (category, deviceId and parameters)
 ```
  
    BMSPushBinder *bmsPushBinder = [BMSPushBinder sharedInstance];
    BMSPushNotificationAction *actionOne = [bmsPushBinder createActionWithIdentifierName:@"FIRST" buttonTitle:@"Accept" isAuthenticationRequired:FALSE defineActivationMode: UIUserNotificationActivationModeForeground];
        
    BMSPushNotificationAction *actionTwo = [bmsPushBinder createActionWithIdentifierName:@"actionTwo" buttonTitle:@"Reject" isAuthenticationRequired:FALSE defineActivationMode: UIUserNotificationActivationModeBackground];

    BMSPushNotificationActionCategory *category = [bmsPushBinder createNotificationActionCategoryWithIdentifierName:@"category" buttonActions:@[actionOne, actionTwo]];
    
    BMSPushClientOptions *notificationOptions = [bmsPushBinder createOptionsWithDeviceId:@"mydeviceID" categories:@[category] parameters:nil];
    
    NSString * appGuid = @"push service appguid";
    NSString * clientSecret = @"push service clientSecret";
    NSString * bluemixRegion = [BMSPushBinder regionUsSouth];
    
    [bmsPushBinder initializeWithAppGUIDWithAppGuid:appGuid clientSecret:clientSecret bluemixRegion: bluemixRegion options:notificationOptions];
 ```

 Initialize push service without category 

 ```
    BMSPushBinder *bmsPushBinder = [BMSPushBinder sharedInstance];
    NSString * appGuid = @"push service appguid";
    NSString * clientSecret = @"push service clientSecret";
    NSString * bluemixRegion = [BMSPushBinder regionUsSouth];
    [bmsPushBinder initializeWithAppGUIDWithAppGuid:appGuid clientSecret:clientSecret bluemixRegion: bluemixRegion options:nil];

 ```

 The `bluemixRegion` can be one of these ,

 - regionUsSouth
 - regionUnitedKingdom
 - regionSydney
 - regionGermany
 - regionUsEast
 - regionJpTok


#### Registration 

To register for push notification, add the following code inside the `application:didRegisterForRemoteNotificationsWithDeviceToken:` method of `AppDelegate.m` file,

```
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    BMSPushBinder *bmsPushBinder = [BMSPushBinder sharedInstance];
    [bmsPushBinder registerForPushWithDeviceToken:deviceToken userId:@"myUserId" completionHandler:^(NSString * response, NSNumber * statusCode, NSString * error) {
        
        if (error != nil) {
            
            NSLog(@"Registration Error, %@", error);
        } else {
            NSLog(@"Registration Success , %@", response);
        }
    }];
    
}
```

#### Un-register from push 

To un-register from the push service ,

```
BMSPushBinder *bmsPushBinder = [BMSPushBinder sharedInstance];
 [bmsPushBinder unregisterFromPushWithCompletionHandler:^(NSString * response, NSNumber * statusCode, NSString * error) {
        
    if(error != nil) {
        NSLog(@"Error : %@", error);
    } else {
        NSLog(@"Unregistred: %@", response.description);
    }
}];
```

#### Retrieve available tags

To retrieve available tags use the following ,

```
 BMSPushBinder *bmsPushBinder = [BMSPushBinder sharedInstance];
[bmsPushBinder retrieveAvailableTagsWithCompletionHandler:^(NSMutableArray * response , NSNumber * statusCode, NSString * error) {
        
        if(error != nil) {
            NSLog(@"Error : %@", error);
        } else {
            
            NSLog(@"Available tags: %@", response.description);
        }
    }];
```


#### Subscribe to tags

To subscribe to tags ,

```
BMSPushBinder *bmsPushBinder = [BMSPushBinder sharedInstance];
[bmsPushBinder subscribeToTagsWithTagsArray:@[@"tag1"] completionHandler:^(NSMutableDictionary * response, NSNumber * statusCode, NSString * error) {
    if(error != nil) {
        NSLog(@"Error : %@", error);
    } else {
        
        NSLog(@"subscribed: %@", response.description);
    }
}];
```

####  un-Subscribe from tags

To Un-Subscribe from tag ,

```

BMSPushBinder *bmsPushBinder = [BMSPushBinder sharedInstance];
[bmsPushBinder unsubscribeFromTagsWithTagsArray:@[@"tag1"] completionHandler:^(NSMutableDictionary * response, NSNumber * statusCode, NSString * error) {
    if(error != nil) {
        NSLog(@"Error : %@", error);
    } else {
        
        NSLog(@"unsubscribed from tags : %@", response.description);
    }
}];
```



### Samples & videos

* Please visit for samples - [Github Sample](https://github.com/ibm-bluemix-mobile-services/bms-samples-swift-hellopush)

* Video Tutorials Available here - [IBM Cloud Push Notifications](https://www.youtube.com/channel/UCRr2Wou-z91fD6QOYtZiHGA)

### Learning More

* Visit the **[IBM Cloud Developers Community](https://developer.ibm.com/bluemix/)**.

* [Getting started with IBM MobileFirst Platform for iOS](https://www.ng.bluemix.net/docs/mobile/index.html)

### Connect with IBM Cloud

[Twitter](https://twitter.com/ibmbluemix) |
[YouTube](https://www.youtube.com/playlist?list=PLzpeuWUENMK2d3L5qCITo2GQEt-7r0oqm) |
[Blog](https://developer.ibm.com/bluemix/blog/) |
[Facebook](https://www.facebook.com/ibmbluemix) |
[Meetup](http://www.meetup.com/bluemix/)


=======================
Copyright 2016 IBM Corp.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
//
//  ViewController.m
//  HelloPush
//
//  Created by Anantha Krishnan K G on 12/02/19.
//  Copyright © 2019 Ananth. All rights reserved.
//

#import "ViewController.h"


static BMSPushBinder* bmsPushBinder = nil;

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    bmsPushBinder = [BMSPushBinder sharedInstance];
    
    
    BMSPushNotificationAction *actionOne = [bmsPushBinder createActionWithIdentifierName:@"FIRST" buttonTitle:@"Accept" isAuthenticationRequired:FALSE defineActivationMode: UIUserNotificationActivationModeForeground];
    
    BMSPushNotificationAction *actionTwo = [bmsPushBinder createActionWithIdentifierName:@"actionTwo" buttonTitle:@"Reject" isAuthenticationRequired:FALSE defineActivationMode: UIUserNotificationActivationModeBackground];

    BMSPushNotificationActionCategory *category = [bmsPushBinder createNotificationActionCategoryWithIdentifierName:@"category" buttonActions:@[actionOne, actionTwo]];
    
    BMSPushClientOptions *notificationOptions = [bmsPushBinder createOptionsWithDeviceId:@"mydeviceID" categories:@[category] parameters:nil];
    
    NSString * appGuid = @"";
    NSString * clientSecret = @"";
    NSString * bluemixRegion = [BMSPushBinder regionUsSouth];
    
    [bmsPushBinder initializeWithAppGUIDWithAppGuid:appGuid clientSecret:clientSecret bluemixRegion: bluemixRegion options:notificationOptions];
    
}


@end

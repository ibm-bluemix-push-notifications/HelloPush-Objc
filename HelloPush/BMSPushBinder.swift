//
//  BMSPushBinder.swift
//  HelloPush
//
//  Created by Anantha Krishnan K G on 12/02/19.
//  Copyright © 2019 Ananth. All rights reserved.
//

import UIKit
import BMSPush
import BMSCore


@objc public protocol BMSPushBinderObserver {
    
    @objc func onChangeInitPermission(status: Bool)
}

@objc public class BMSPushBinder: NSObject,BMSPushObserver {

    
    @objc public static let sharedInstance = BMSPushBinder()
    private var push:BMSPushClient?
    /**
     The southern United States Bluemix region.
     */
    @objc public static let regionUsSouth = ".ng.bluemix.net"
    
    /**
     The United Kingdom Bluemix region.
     */
    @objc public static let regionUnitedKingdom = ".eu-gb.bluemix.net"
    
    /**
     The Sydney Bluemix region.
     */
    @objc public static let regionSydney = ".au-syd.bluemix.net"
    
    /**
     The Germany Bluemix region.
     */
    @objc public static let regionGermany = ".eu-de.bluemix.net"
    
    /**
     The Washington Bluemix region.
     */
    @objc public static let regionUsEast = ".us-east.bluemix.net"
    
    /**
     The Tokyo Bluemix region.
     */
    @objc public static let regionJpTok = ".jp-tok.bluemix.net"
        
    
    public func onChangePermission(status: Bool) {
        
        print("Push Notification is enabled:  \(status)" as NSString)
        if status {
          
            // Init was Successful
        } else {
            // Error in Init
        }
    }
    
    
    // MARK: TODO
    /**
      Init push
     - parameter appGUID:    The pushAppGUID of the Push Service
     - parameter clientSecret:  The clientSecret of the Push Service
     - parameter bluemixRegion: The region where your Bluemix application is hosted. Use one of the `BMSClient.Region` constants.
     - parameter options: The push notification options
     */
    @objc public func initializeWithAppGUID(appGuid:String, clientSecret: String, bluemixRegion:String ,  options: BMSPushClientOptions? = nil ) {
        BMSClient.sharedInstance.initialize(bluemixRegion: bluemixRegion)
        
        push =  BMSPushClient.sharedInstance
        push?.delegate = self
        
        if let optionsValue = options {
            push?.initializeWithAppGUID(appGUID: appGuid, clientSecret: clientSecret, options: optionsValue)
        } else {
            push?.initializeWithAppGUID(appGUID: appGuid, clientSecret: clientSecret)
        }
    }
    
    /**
     Resgister device token
     - parameter deviceToken:    deviceToken from APNS
     - parameter userId:  User Id value (Optional)
     - parameter completionHandler: a completion Handler.
     */
    @objc func registerForPush(deviceToken: Data, userId:String? = nil, completionHandler: @escaping(_ response:String?, _ statusCode:NSNumber?, _ error:String?) -> Void ) {
        
        
        if let userIdValue = userId {
            
            push?.registerWithDeviceToken(deviceToken: deviceToken, WithUserId: userIdValue, completionHandler: { (response, statusCode, error) in
                completionHandler(response, NSNumber(integerLiteral: statusCode ?? 0), error)
            })
        } else {
            
            push?.registerWithDeviceToken(deviceToken: deviceToken, completionHandler: { (response, statusCode, error) in
                completionHandler(response, NSNumber(integerLiteral: statusCode ?? 0), error)
            })
        }
        
    }
    
    /**
     unregister from push service
     - parameter completionHandler: a completion Handler.
     */
    @objc func unregisterFromPush(completionHandler: @escaping(_ response:String?, _ statusCode:NSNumber?, _ error:String?) -> Void) {
        
        push?.unregisterDevice(completionHandler: { (response, statusCode, error) in
            completionHandler(response, NSNumber(integerLiteral: statusCode ?? 0) , error)
        })
    }
    
    /**
     retrieve Subscriptions from push service
     - parameter completionHandler: a completion Handler.
     */
    @objc func retrieveSubscriptions(completionHandler: @escaping(_ response:NSMutableArray?, _ statusCode:NSNumber?, _ error:String?) -> Void) {
        
        push?.retrieveSubscriptionsWithCompletionHandler(completionHandler: { (response, statusCode, error) in
            completionHandler(response, NSNumber(integerLiteral: statusCode ?? 0), error)
        })
    }
    
    /**
     retrieve available tags from push service
     - parameter completionHandler: a completion Handler.
     */
    @objc func retrieveAvailableTags(completionHandler: @escaping(_ response:NSMutableArray?, _ statusCode:NSNumber?, _ error:String?) -> Void) {
        
        push?.retrieveAvailableTagsWithCompletionHandler(completionHandler: { (response, statusCode, error) in
            completionHandler(response, NSNumber(integerLiteral: statusCode ?? 0), error)
        })
    }
    
    /**
     Subscribe to array of tags
     - parameter tagsArray: Array of tag strings . eg; ["tag1", "tag2"]
     - parameter completionHandler: a completion Handler.
     */
    @objc func subscribeToTags(tagsArray: NSArray, completionHandler: @escaping(_ response:NSMutableDictionary?, _ statusCode:NSNumber?, _ error:String?) -> Void) {
        push?.subscribeToTags(tagsArray: tagsArray, completionHandler: { (response, statusCode, error) in
            completionHandler(response, NSNumber(integerLiteral: statusCode ?? 0), error)
        })
    }
    
    /**
     Un-Subscribe to array of tags
     - parameter tagsArray: Array of tag strings . eg; ["tag1", "tag2"]
     - parameter completionHandler: a completion Handler.
     */
    @objc func unsubscribeFromTags(tagsArray: NSArray, completionHandler: @escaping(_ response:NSMutableDictionary?, _ statusCode:NSNumber?, _ error:String?) -> Void) {
        
        push?.unsubscribeFromTags(tagsArray: tagsArray, completionHandler: { (response, statusCode, error) in
            completionHandler(response, NSNumber(integerLiteral: statusCode ?? 0), error)
        })
    }
    
    @objc func createAction(identifierName identifier: String, buttonTitle title: String, isAuthenticationRequired authenticationRequired: Bool, defineActivationMode activationMode: UIUserNotificationActivationMode) -> BMSPushNotificationAction {
        
        return BMSPushNotificationAction(identifierName: identifier, buttonTitle: title, isAuthenticationRequired: authenticationRequired, defineActivationMode: activationMode)
        
    }
    
    @objc func createNotificationActionCategory(identifierName: String, buttonActions: [BMSPushNotificationAction]) -> BMSPushNotificationActionCategory {
        
        return BMSPushNotificationActionCategory(identifierName: identifierName, buttonActions: buttonActions)
    }
    
    @objc func createOptions(deviceId:String? = nil, categories:[BMSPushNotificationActionCategory]? = nil, parameters: [String:String]? = nil ) -> BMSPushClientOptions{
        
        let notificationOptions = BMSPushClientOptions()
        
        if let deviceIdValue = deviceId {
            notificationOptions.setDeviceId(deviceId: deviceIdValue)
        }
        
        if let categoriesArray = categories {
            notificationOptions.setInteractiveNotificationCategories(categoryName: categoriesArray)
        }
        
        if let parametersDictionary = parameters {
            notificationOptions.setPushVariables(pushVariables: parametersDictionary)
        }
        
        return notificationOptions
    }
}

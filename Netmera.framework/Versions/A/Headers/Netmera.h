/*
 * Copyright 2012 Inomera Research
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * version 2.4.2
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "zlib.h"
#import "NMGeolocation.h"
#import "NMDeviceDetail.h"
#import "NMPushManager.h"
#import "NMDeviceDetail.h"
#import "NMLocationManager.h"
#import "NMPushInboxList.h"
#import "NMRichPushObject.h"
#import "NMRichPushSenderObject.h"
#import "NMPushReport.h"
#import "NMEvent.h"
#import "NMReachability.h"
#import "NMNotificationController.h"
#import "NMProgressHUD.h"
#import "NMPopupObject.h"
#import "NMPopupManager.h"
#import "NMJSONCategories.h"
#import "NMAppInfo.h"
#import "NMAlertView.h"

#define NMLocalizedString(key,val) [[NSBundle mainBundle] localizedStringForKey:key value:val table:@"NetmeraLocalization"]



// SDKReleaseVersion
extern NSString * const kSDKReleaseVersion;

// Server Domain
extern NSString * const kServerDomain;

/**
 * Netmera class is the base class for Netmera SDK. You can configure how Netmera should behave using this class.
 * Also, you can get InstallationId of your application using [Netmera getInstallationId] class method.
 */
@interface Netmera : NSObject

/**
 * Returns application-specific key received from Netmera and set in the application.
 *
 *  @return The string value which refers to api key.
 */
+ (NSString*)apiKey;

/**
 * Sets the application-specific key received from Netmera for the application requests.
 *
 * This value is unique for every application, therefore Netmera determines which app sends whichever requests. This 
 *  is the required value that must be set for every application before making any interaction with Netmera.
 *
 *  @param key The unique value received from "Overview" section of your application in Netmera website.
 *
 *  @discussion You can set the api key by either calling this method with the relevant parameter or adding manually
 *      it into NetmeraSettings.plist.
 */
+ (void)setApiKey:(NSString*)key;

/**
 * Returns a unique string that could be used to identify the device for the application.
 *
 *  @return The string value generating exclusively for the application.
 */
+ (NSString*)getInstallationId;

/**
 * Sets a timeout value for all sending requests from Netmera SDK throughout the application. The default value is 60 
 *  seconds.
 *
 *  @param seconds Value used as the timeout interval for requests.
 *
 *  @discussion You should not set a short timeout interval, because this may prevents Netmera SDK to send requests in 
 *      weak internet connections.
 */
+ (void)setGlobalRequestTimeout:(NSTimeInterval)seconds;

/**
 * Returns the boolean value that determines whether the push inbox is enabled or not. The default value is YES.
 *
 *  @return The enabled or disabled boolean value.
 */
+ (BOOL)pushInboxEnabled;

/**
 * Sets the boolean value that determines whether the push inbox controller is available for your application or not when a rich
 *  push message is received. The default value is YES.
 *
 *  @param enabled The boolean value that enables push inbox or not.
 */
+ (void)setPushInboxEnabled:(BOOL)enabled;

/**
 * Returns the boolean value that determines whether Netmera should manage application badge number depending on number of unread pushes in push inbox. The default value is YES.
 *
 *  @return The enabled or disabled boolean value.
 */
+ (BOOL)pushInboxBadgeUpdateEnabled;

/**
 * Sets the boolean value that determines whether Netmera should manage application badge number depending on number of unread pushes in push inbox.
 * The default value is YES.
 *
 *  @param enabled The boolean value that enables push inbox or not.
 */
+ (void)setPushInboxBadgeUpdateEnabled:(BOOL)enabled;


/**
 * Returns the boolean value for receiving rich pushes to be displayed immediately or be asked whether rich pushes are
 *  displayed or not with an alert box. The default value is YES.
 *
 *  @return The boolean value that shows whether the rich push is shown immediately or not.
 */
+ (BOOL)richPushShouldBeShownImmediately;

/**
 * Sets the boolean value for receiving rich pushes to be displayed immediately or not. If shouldBeShown value is YES, 
 *  receiving rich push is displayed on the screen directly without any alert. If it is NO, then an alert box, which waits 
 *  a confirmation about if rich push should be shown or not from the user is shown on the screen. The default value is YES.
 *
 *  @param shouldBeShown The boolean value that controls the display of the rich pushes.
 */
+ (void)setRichPushShouldBeShownImmediately:(BOOL)shouldBeShown;

/**
 * Returns the boolean value which indicates whether a loading indicator is displayed or not when showing rich push 
 *  notifications. The default value is YES.
 *
 *  @return The boolean value showing that a progress HUD should be displayed or not.
 */
+ (BOOL)richPushShouldShowProgressHUD;

/**
 * Sets the boolean value whether a progress HUD should be displayed or not while setting up a receiving rich push 
 *  notification. The default value is YES.
 *
 *  @param shouldShow The boolean value that activates or deactivates a loading indicator.
 */
+ (void)setRichPushShouldShowProgressHUD:(BOOL)shouldShow;

/**
 * Returns the boolean value which indicates whether locationTracking is enabled or disabled. Default value is YES.
 *
 *  Users' locations are tracked by default (using startMonitoringSignificantLocationChanges method of CLLocationManager
 *    class). If you want to disable tracking user's location, you should call [NetmeraClient setLocationTrackingEnabled:NO]
 *    in application:didFinishLaunchingWithOptions: method in your app delegate.
 *
 *  @return The boolean value that enables or disables locationTracking.
 *
 *  @discussion This flag does NOT affect operation of Geofence Service. You can start or stop a geofence service 
 *      regardless of this flag.
 */
+ (BOOL)significantLocationChangeTrackingEnabled;

/**
 * Sets the boolean value that shows whether locationTracking should be enabled or disabled. Default value is YES.
 *
 * Users' locations are tracked by default (using startMonitoringSignificantLocationChanges method of CLLocationManager
 *  class). If you want to disable tracking user's location, you should call [NetmeraClient setLocationTrackingEnabled:NO] 
 *  in application:didFinishLaunchingWithOptions: method in your app delegate.
 *
 *  @param enabled The boolean value that enables locationTracking or not.
 *
 *  @discussion This flag does NOT affect operation of Geofence Service. You can start or stop a geofence service 
 *  regardless of this flag.
 */
+ (void)setSignificantLocationChangeTrackingEnabled:(BOOL)enabled;

@end



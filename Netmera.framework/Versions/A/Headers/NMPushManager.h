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

#import "Netmera.h"
#import "NMProgressHUD.h"

@class NMPushObject;
@class NMRichPushObject;

typedef void(^NMRichPushCompletionHandler)(NSError *error);

/**
 @typedef
 @brief List of states that describes application state when a push notification is received.
 @note You should use these enum values together with UIApplicationState values to determine exact cases when push notification is received.
 */
typedef enum{
    /// App was not running at all when push notification is received
    NMAppStateWasNotRunning,
    /// App was in background (running or suspended) when push notification is received
    NMAppStateWasInBackground,
    /// App was running in foreground when push notification is received
    NMAppStateWasInForeground
} NMAppState;

/**
 * NMPushManagerDelegate protocol defines methods to track and decide what to do when a push notification is received. You should implement these methods to have advanced control over push notification handling process.
 *
 * @warning Currently, if a push notification that is sent from Netmera is received, default remote notification delegate methods are also called in addition to NMPushManagerDelegate protocol methods. THIS BEHAVIOR WILL BE CHANGED IN THE NEXT MAJOR RELEASE. If the push notification is sent via Netmera, only NMPushManagerDelegate methods will be called. Therefore, you should update your code and start to use NMPushManagerDelegate methods to manage push notification handling for notifications coming from Netmera.
 */
@protocol NMPushManagerDelegate <NSObject>

@optional

/**
 *  Called whenever a push notification is received. This method will NOT be called if didReceivePush:appState:fetchCompletionHandler: method is implemented.
 *
 *  @param push Push object that is received. It may be an NMPushObject or an NMRichPushObject. You can check via type property of NMPushObject class.
 *  @param state An enum value that describes the state when app has received given push notification. For possible values, see NMAppState.
 *
 *  @note You can implement this method instead of didReceivePush:appState:fetchCompletionHandler: if you do not enable "remote-notification" background mode.
 */
- (void)didReceivePush:(NMPushObject*)push appState:(NMAppState)state;

/**
 * @brief Called whenever a push notification is received. This method overrides didReceivePush:appState: method.
 *
 * @param push Push object that is received. It may be an NMPushObject or an NMRichPushObject. You can check via type property of NMPushObject class.
 * @param state An enum value that describes the state when app has received given push notification. For possible values, see NMAppState.
 * @param completionHandler You should call the completionHandler as soon as you're finished your task, so the system can accurately estimate its power and data cost.
 *
 * @note You should implement this method if you enable "remote-notification" background mode.
 */
- (void)didReceivePush:(NMPushObject*)push appState:(NMAppState)state fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

/**
 * Called when your app has been activated by the user via selecting an action from an interactive push notification. You can check push.actionIdentifier value to get action identifier of the touched action button.
 *
 * @param push Push object that is received. You can get parameters set to the action from Netmera panel via push.actionParams property.
 * @param state An enum value that describes the state when app has received given push notification. For possible values, see NMAppState.
 * @param completionHandler You should call the completion handler as soon as you've finished handling the action.
 
 * @note You should implement this method if you are using interactive notifications in your application.
 */
- (void)handleActionForPush:(NMPushObject*)push appState:(NMAppState)state completionHandler:(void(^)())completionHandler;

/**
 * Method that asks whether received rich push notification should be presented by Netmera SDK automatically. 
 * @note If you do NOT implement this method, SDK will automatically present received rich push notifications considering preferences set in NetmeraSettings.plist file. You should implement this method and return NO if you want to handle presentation of received rich push notications yourself.
 * @param richPush Rich push object that is received.
 * @return A boolean value which determines if given rich push should be presented by SDK automatically.
 */
- (BOOL)shouldPresentRichPush:(NMRichPushObject*)richPush;


/**
 *  If an interactive push is received when app is foreground, SDK present an alert containing action buttons to user by default. To disable this, implement this method and return NO.
 *
 *  @param push Received interactive push notification.
 *
 *  @return Boolean value to determine if SDK should automatically present an alert.
 */
- (BOOL)shouldPresentInteractivePushInForeground:(NMPushObject*)push;

@end

/**
 * NMPushManager class manages push notification registration and handling process.
 */
@interface NMPushManager : NSObject

/**
 * You can set any object that conforms to NMPushManagerDelegate protocol as the delegate for push notification events. By default, your application's "AppDelegate" object is the delegate for events about push notifications sent from Netmera.
 */
+ (void)setDelegate:(id<NMPushManagerDelegate>)delegate;

/**
 * Returns the hexadecimal string representation of the 'deviceToken'.
*/
+ (NSString *)deviceToken;

/**
 * Sets the set of UIUserNotificationCategory objects for interactive notifications.
 *
 * This method internally creates a UIUserNotificationSettings object having given categories, and registers the device to this settings object using registerUserNotificationSettings: method.
 *
 *  @param categories The set containing UIUserNotificationCategory objects.
 *
 *  @warning If any of the objects does NOT belong UIUserNotificationCategory class, method does NOT register the given category set.
 */
+ (void)setUserNotificationCategories:(NSSet*)categories;

/**
 * Sets enabled user notification types for push notifications.
 *
 *  @param type A UIUserNotificationType enum.
 */
+ (void)setEnabledUserNotificationTypes:(UIUserNotificationType)type;

#pragma mark - push register/unregister process
///---------------------
/// @name Push Registration
/// All of the following register/unregister methods are called asynchronously.
///---------------------


/**
 * Registers the device to Netmera for push notifications.
 *
 *  @param handler The block to execute when the registration of the device is completed.
 */
+ (void)registerWithCompletionHandler:(void(^)(BOOL deviceDidRegister, NSError *error))handler;

/**
 * Registers the device with the related attributes - namely tag, customDictionary and location.
 *
 *  @param deviceDetail The NMDeviceDetail object which contains the relevant attributes.
 *
 *  @param handler The block to execute when the registration of the device with the given attributes is completed.
 */

+ (void)registerWithDeviceDetail:(NMDeviceDetail *)deviceDetail completionHandler:(void(^)(BOOL deviceDidRegister, NSError *error))handler;

/**
 * Unregisters the device completely from Netmera for push notifications.
 *
 *  @param handler The block to execute when the unregistration of the device is completed.
 */
+ (void)unregisterWithCompletionHandler:(void(^)(BOOL deviceDidUnregister, NSError *error))handler;

/**
 * Unregisters the device from the tags that just set on the given NMDeviceDetail object.
 *
 *  @param deviceDetail The NMDeviceDetail object which contains the tags that will be unregistered.
 *
 *  @param handler The block to execute when the unregistration of the device from the given tags is completed.
 */
+ (void)unregisterWithDeviceDetail:(NMDeviceDetail *)deviceDetail completionHandler:(void(^)(BOOL deviceDidUnregister, NSError *error))handler;

/**
 * Returns all tags registered for device.
 *
 *  @param handler The block to execute when the fetch of the tags is completed.
 *
 *  @discussion You should beware that tag list returned from this method contains the tags other devices registered to, 
 *      not just the regarding device.
 */
+ (void)getDeviceTagsWithCompletionHandler:(void(^)(NSArray *tags, NSError *error))handler;


#pragma mark - Rich Push Handling

/**
 * Use this method to manually present push inbox on your view controller hierarchy. Push Inbox controller will be 
 *  presented on given controller as a modalviewcontroller.
 *
 *  @param parentController The controller object which will present push inbox modally.
 */
+ (void)presentPushInboxFromController:(UIViewController*)parentController;

/*
 * Following two methods determines the time intervals at which rich push notifications that comes during app is runnning
 *  should be shown to user or not.
 * By default, coming rich pushes are shown to users according to specified presentation procedure (which is determined by
 *  RichPushShouldBeShownImmediately key in NetmeraSettings.plist file).
 * If you call [NMPushManager beginIgnoringRichPushes] method in your code, received rich pushes during foreground state 
 *  will be ignored by Netmera, and won't be shown to user, until
 *
 *      [NMPushManager endIgnoringRichPushes] method is called.
 */
/**
 * Method which makes Netmera to ignore received rich pushes when application is on the foreground so that rich pushes does 
 *  NOT interrupt users' actions.
 *
 *  @warning If you call [NMPushManager beginIgnoringRichPushes] method in your code, received rich pushes during
 *      foreground state will be ignored by Netmera, and won't be shown to user, until [NMPushManager endIgnoringRichPushes]
 *      method is called.
 */
+ (void)beginIgnoringRichPushes;

/**
 * Method which makes Netmera to stop ignoring received rich pushes when application is on the foreground so that rich 
 *  pushes will be shown to user after this call.
 */
+ (void)endIgnoringRichPushes;

/**
 * Returns the indicator object used for the process of the loading of a rich push notification and push inbox.
 *
 *  @return NMProgressHUD object that is set for the loading indicator.
 */
+ (NMProgressHUD *)loadingHUD;

/**
 * Sets the indicator object used for the process of the loading of a rich push notification and push inbox.
 *
 *  @param progressHUD Configured loading indicator.
 *
 *  @discussion For a custom loading indicator, you should configure NMProgressHUD object. It offers a rich interface. 
 *      By default, a basic design of NMProgressHUD is used.
 */
+ (void)setLoadingHUD:(NMProgressHUD *)progressHUD;

/**
 * Controls the availability of a rich push notification to show. Existance of internet connection is considered in the 
 *  scope of availability.
 *
 *  @return availability of rich push notification.
 */
+ (BOOL)checkAvailability;

@end


//This category enables your AppDelegate class to autocomplete NMPushManagerDelegate methods.
@interface UIResponder (NMRuntime) <NMPushManagerDelegate>

@end

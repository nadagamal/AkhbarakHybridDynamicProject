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

/**
 * @typedef
 * @brief List of notification types.
 */
typedef enum {
    ///Type is NOT defined
    NMNotificationTypeNone = 0,
    ///Type for standart push notifications
    NMNotificationTypeStandard = 1 << 1,
    ///Type for rich push notifications
    NMNotificationTypeRich = 1 << 2,
    ///Type for rich push notifications with a URL content
    NMNotificationTypeURLPush = 1 << 3,
    ///Type for popups
    NMNotificationTypePopup = 1 << 4,
    ///Type for interactive notifications (Interactive notifications received to devices having iOS7 or before will have type NMNotificationTypeStandard!!)
    NMNotificationTypeInteractive = 1 << 5,
    ///All notification types
    NMNotificationTypeAll = NMNotificationTypePopup | NMNotificationTypeRich | NMNotificationTypeStandard | NMNotificationTypeURLPush | NMNotificationTypeInteractive
} NMNotificationType;

/**
 * @typedef
 * @brief List of push inbox status masks for notifications.
 */
typedef enum
{
    ///Status is NOT defined
    NMPushInboxStatusNone = 0,
    ///Notification is read
    NMPushInboxStatusRead = 1 << 1,
    ///Notification is unread
    NMPushInboxStatusUnread = 1 << 2,
    ///Notification is deleted
    NMPushInboxStatusDeleted = 1 << 3,
    ///All statuses
    NMPushInboxStatusAll = NMPushInboxStatusRead | NMPushInboxStatusUnread | NMPushInboxStatusDeleted
} NMPushInboxStatus;


@interface NMPushObject : NSObject

/** 
 * Plain message of the push notification.
 */
@property (nonatomic, strong) NSString *alertText;

/**
 * Dictionary which contains custom parameters, which are sent with rich push message content.
 */
@property (nonatomic, strong) NSMutableDictionary *customParams;

/**
 * Dictionary which contains custom parameters sent by the event which auto-triggers this push notification.
 */
@property (nonatomic, strong) NSMutableDictionary *eventCustomParams;

/**
 * Id of the push notification that is sent to the devices.
 */
@property (nonatomic, strong) NSString *notificationId;

/** 
 * Creation Date of the push notification.
 */
@property (nonatomic, strong) NSDate *createDate;

/**
 * Send Date of the push notification.
 */
@property (nonatomic, strong) NSDate *sendDate;

/**
 * Expiration Date of the push notification.
 */
@property (nonatomic, strong) NSDate *expirationDate;

/**
 * Type of the created push notification object.
 *
 *  @warning enum NotificationType options.
 *
 *      NotificationTypeStandard, plain-text push notification is sent to the relevant devices.
 *
 *      NotificationTypeRich, push notification that contains HTML-formatted rich content is sent to the relevant devices.
 *
 *      NotificationTypePopup, pop-up object that contains HTML-formatted content.
 *
 *      NotificationTypeURLPush, push notification that contains an URL for the rich content is sent to the relevant devices.
 */
@property (nonatomic, assign) NMNotificationType type;

/**
 * Status of the rich push according to functions to perform.
 *  @warning enum PushStatus options.
 *
 *      PushStatusRead, it shows that the rich push is read.
 *
 *      PushStatusUnread, it shows that the rich push is unread.
 *
 *      PushStatusDeleted, it shows that the rich push is deleted.
 */
@property (nonatomic,assign) NMPushInboxStatus pushInboxStatus;

/**
 * A string value that can be set from Netmera panel while sending push notifications.
 *
 * Provides a way to categorize push notifications in a customized manner.
 */
@property (nonatomic, strong) NSString *category;


/**
 * A URL string that can be set from Netmera panel while sending push notifications.
 * You can give logo image paths for the push notification that you sent, and show it in your custom list.
 */
@property (nonatomic, strong) NSString *pushLogoURL;

/**
 * Fetches details of the push object from Netmera.
 *
 * @param handler The block to execute when the details of the push notifications is fetched from Netmera.
 */
- (void)fetchPushDetailsWithCompletionHandler:(void(^)(NSError* error))handler;


/**
 * Converts a relevant string format into NotificationType enum type.
 *
 *  @param typeString String representation of the push notification type.
 *
 *  @return Corresponding enum type of the push notification type.
 */
+ (NMNotificationType)notificationTypeFromString:(NSString *)typeString;

/**
 * Converts NotificationType enum type into string format that refers to notification type.
 *
 *  @param type Enum type of the push notification type.
 *
 *  @return Corresponding string of the push notification type.
 */
+ (NSString *)stringFromNotificationType:(NMNotificationType)type;


///---------------------
/// @name Interactive Notification
///---------------------

//TODO: WRITE DOCSET
@property (nonatomic, strong) NSString  *interactivePushCategoryIdentifier;

/**
 *  This value is set when there is action specific parameters set in Netmera panel for selected action. If there are no parameters specified for selected action, value returns nil.
 */
@property (nonatomic, strong) NSDictionary *actionParams;

/**
 *  This value is set when user selects an action button for an interactive notification, and contains identifier of selected action. Default is nil.
 */
@property (nonatomic, strong) NSString *actionIdentifier;

@end


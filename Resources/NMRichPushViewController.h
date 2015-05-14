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

#import <UIKit/UIKit.h>
#import <Netmera/Netmera.h>
@class NMRichPushObject;

/** 
 * NMRichPushViewController is the controller, which shows the content of given rich push notification or pop up notification.
 *  As default implementation:
 *      - For rich push notifications, it displays the coming rich push notifications as if they are opened in push inbox 
 *      implementation.
 *      - For pop up notifications, it shows view with a popping animation.
 */

@interface NMRichPushViewController : NMNotificationController

@property (nonatomic, strong) NMRichPushObject *richPush;

-(id)initWithRichPushObject:(NMRichPushObject*)obj;

@end

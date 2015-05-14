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
#import <QuartzCore/QuartzCore.h>
#import "Netmera.h"

/**
 * NMNotificationController class is the base class for rich push and pop up notification controllers. It handles low level 
 *  management of notification controllers. Also there is a sample implementation of this superclass in NMRichPushViewController
 *  class. You can implement your custom controller for presenting notifications by subclassing NMNotificationController class.
 */

@interface NMNotificationController : UIViewController <UIWebViewDelegate>

- (id)initWithPushObject:(NMPushObject *)obj;

/**
 * The object, which stores the rich push content.
 */
@property (nonatomic, strong) NMPushObject *pushObject;

/**
 * The webview, which displays the rich push content.
 */
@property(nonatomic, strong) UIWebView *webView;

/**
 * The boolean value which shows whether the script that tracks the rich push action events should be added into the 
 *  webview or not.
 */
@property (nonatomic, assign) BOOL shouldInsertJS;


/**
 * This method asks for user's permission to update current rich push view with the newly-receiving rich push object when NMRichPushViewController is visible.
 * If user approves, new rich push is shown to user.
 * @param richObject Newly receiving rich push object.
 */
- (void)requestUpdateWithRichPushObject:(NMRichPushObject *)richObject;

/**
 * Updates webview content with the newly-receiving rich push object when NMRichPushViewController is visible.
 *
 * @param richObject Newly receiving rich push object.
 */
- (void)updateWithRichPushObject:(NMRichPushObject *)richObject;

@end

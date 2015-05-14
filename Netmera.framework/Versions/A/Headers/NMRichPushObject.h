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
#import "NMPushObject.h"

/**
 * NMRichPushObject class stores related data of a rich push message.
 */
@interface NMRichPushObject : NMPushObject

/**
 * HTML string that will be shown as rich push message content if any.
 */
@property (nonatomic, strong) NSString *htmlBody;

/**
 * URL string that will bw shown as rich push content if any.
 */
@property (nonatomic, strong) NSString *urlString;

/**
 * Boolean value which indicates that the receiving rich push should be placed in Inbox
 */
@property (nonatomic, assign) BOOL shouldShownInInbox;

/**
 * This method handles urls in the rich push content, and check whether related action contains a custom event. If yes, 
 *  it sends related event data to server.
 *
 *  @param url URL which is triggered in the rich push content.
 *
 *  @return BOOL returns YES if url contains a custom event. You should return NO to
 *      webView:shouldStartLoadWithRequest:navigationType: delegate method if this method returns YES.
 */
- (BOOL)handleEventURL:(NSURL*)url;

/**
 * This method can be used if you want to show rich push content in a webview that you create. Method takes a web view, and loads content of
 * the popup notification to web view. Using this method, you can show your popups in views with any way you want.
 * 
 * This method sets itself to given webview's delegate. However, it does NOT interrupt your delegate logic. All webview delegate methods that you implement  will be called.
 *
 * NOTE: You should set your delegate object to webview before calling this method!
 *
 *  @param webView UIWebView object which will show popup.
 */
- (void)presentInWebView:(UIWebView*)webView;


@end

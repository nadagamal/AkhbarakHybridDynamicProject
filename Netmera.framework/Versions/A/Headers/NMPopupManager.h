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

#import <Foundation/Foundation.h>
#import "NMPopupObject.h"

typedef void(^NMPopupTriggerResult)(NSMutableArray *triggeredPopups);

typedef void(^NMPopupRegisterResult)(NSError *error);

/**
 * NMPopupManager is the service which manages popup notification flow. It provides means to register to popup notification
 *  service, to retrieve available popups, and to present popup objects on screen.
 * All popup notifications are binded to some event, which means that related popup will be available to retrieve only 
 *  after it's binded event is fired.
 */
@interface NMPopupManager : NSObject

/**
 * Adds an object as an observer for the given event for triggered popups. When the relevant event fires, the given block
 *  is executed automatically. For an event, you can define as many as objects as an observer.
 *
 *  @param object The object registered as an observer. It is recommended to set a UIViewController object to this parameter
 *      since it is easier to control the triggered popup object in a controller object.
 *
 *  @param key The description of an event which is requested to track for popup objects.
 *
 *  @param resultBlock The block to execute when the relevant event fires. It returns the triggered popups binded to the 
 *      given event.
 */
+ (void)addObserver:(id)object forEventKey:(NSString *)key usingBlock:(NMPopupTriggerResult)resultBlock;

/**
 * Adds an object as an observer for all events for triggered popups. When any event fires, the given block
 *  is executed automatically. You can define as many as objects as an observer.
 *
 *  @param object The object registered as an observer. It is recommended to set a UIViewController object to this parameter
 *      since it is easier to control the triggered popup object in a controller object.
 *
 *  @param resultBlock The block to execute when the relevant event fires. It returns the triggered popups binded to the
 *      given event.
 */
+ (void)addObserverForAllEvents:(id)object usingBlock:(NMPopupTriggerResult)resultBlock;

/**
 * Removes the object registered as an observer for the regarding event. If a UIViewController object is added as an observer,
 *  it is highly recommended to call this method at least dealloc method of the relevant controller.
 *
 *  @param object The object registered as an observer.
 *
 *  @param key The description of the event which is not requested to listen any more.
 */
+ (void)removeObserver:(id)object forEventKey:(NSString *)key;

/**
 * Removes the object registered as an observer for the all event. If a UIViewController object is added as an observer,
 *  it is highly recommended to call this method at least dealloc method of the relevant controller.
 *
 *  @param object The object registered as an observer.
 */
+ (void)removeObserverForAllEvents:(id)object;

/**
 * Method to retrieve popups whose binded events are fired.
 *
 *  @return An array of popup objects which are triggered by some event.
 */
+ (NSMutableArray *)getTriggeredPopups;

/**
 * Method to retrieve popups which are binded to event with given key.
 *
 *  @param key Key of the requested event.
 *
 *  @return An array of popup objects which are triggered by event with given key.
 */
+ (NSMutableArray *)getTriggeredPopupsWithEventKey:(NSString *)key;

/**
 * Presents given popup object on top of current visible view controller. Popup will be shown in a controller with a full 
 *  screen view, using a popping animation.
 *
 *  @param object Popup notification object to be shown.
 */
+ (void)presentPopup:(NMPopupObject*)object;

/**
 * Presents given popup object on top of given view controller. Popup will be shown in a controller with a full screen view,
 *  using a popping animation.
 *
 *  @param object Popup notification object to be shown.
 */
+ (void)presentPopup:(NMPopupObject*)object fromController:(UIViewController*)parentController;

@end

//
//  MKBlockAdditions.h
//  UIKitCategoryAdditions
//
//  Created by Mugunth on 21/03/11.
//  Copyright 2011 Steinlogic All rights reserved.
//

typedef void (^NMVoidBlock)();

typedef void (^NMDismissBlock)(NSInteger buttonIndex);
typedef void (^NMCancelBlock)();
typedef void (^NMPhotoPickedBlock)(UIImage *chosenImage);
typedef void (^NMUIViewControllerBlock)(UIViewController *controller);

#define kPhotoActionSheetTag 10000

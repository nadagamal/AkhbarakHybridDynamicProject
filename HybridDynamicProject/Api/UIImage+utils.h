//
//  UIImage+utils.h
//  Reyada
//
//  Created by MohamedMansour on 1/14/15.
//  Copyright (c) 2015 Sarmady.net. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage(utils)
//extract a portion of an UIImage instance
-(UIImage *) cutout: (CGRect) coords;
//create a stretchable rendition of an UIImage instance, protecting edges as specified in cornerCaps
-(UIImage *) stretchImageWithCapInsets: (UIEdgeInsets) cornerCaps toSize: (CGSize) size;
@end
//
//  ViewColors.h
//  ColorSelection
//
//  Created by Sveta Kilovata on 25/10/15.
//  Copyright © 2015 Sveta Kilovata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewColors : UIView

- (UIColor *)colorWithValue:(CGFloat)value;
- (CGFloat)recalculateCenterOfColorWithValue:(CGFloat)value;
- (BOOL)isExistColor:(UIColor *)color;
- (CGFloat)positionOfColor:(UIColor *)color;

@end

//
//  ViewColors.m
//  ColorSelection
//
//  Created by Sveta Kilovata on 25/10/15.
//  Copyright © 2015 Sveta Kilovata. All rights reserved.
//

#import "ViewColors.h"

@interface ViewColors()

@property (nonatomic, strong) NSArray *arrayColors;
@property (nonatomic, strong) NSArray *arrayColorsPositions;

@end

@implementation ViewColors

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.arrayColors = @[[self colorWithHexValue:0xE936B7],
                             [self colorWithHexValue:0x9A27E9],
                             [self colorWithHexValue:0x3F77E6],
                             [self colorWithHexValue:0x02C0EF],
                             [self colorWithHexValue:0x15D5A0],
                             [self colorWithHexValue:0x548E34],
                             [self colorWithHexValue:0x6EC426],
                             [self colorWithHexValue:0xECBB00],
                             [self colorWithHexValue:0xF7811B],
                             [self colorWithHexValue:0xD91F1F]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSMutableArray *arrayPositions = [NSMutableArray array];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSInteger widthColor = self.bounds.size.width/self.arrayColors.count;
    NSInteger lastWidthColor = rect.size.width - widthColor*(self.arrayColors.count-1);
    CGFloat originX = 0;
    [arrayPositions addObject:@(originX)];
    for (NSInteger i = 0; i < self.arrayColors.count; i++)
    {
        CGColorRef color = [self.arrayColors[i] CGColor];
        CGContextSetFillColorWithColor(context, color);
        if (i == self.arrayColors.count-1)
        {
            CGContextFillRect(context, CGRectMake(originX, rect.origin.y, lastWidthColor, rect.size.height));
        }
        else
        {
            CGContextFillRect(context, CGRectMake(originX, rect.origin.y, widthColor, rect.size.height));
        }
        originX += widthColor;
        [arrayPositions addObject:@(originX)];
    }
    self.arrayColorsPositions = [arrayPositions copy];
}

- (UIColor *)colorWithValue:(CGFloat)value
{
    return [self colorAtPosition:CGPointMake(value, 1.f)];
}

- (UIColor *)colorAtPosition:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

- (CGFloat)recalculateCenterOfColorWithValue:(CGFloat)value
{
    CGFloat minColorPosition = 0;
    CGFloat maxColorPosition = 0;
    if (value > [[self.arrayColorsPositions lastObject] floatValue])
    {
        value = [[self.arrayColorsPositions lastObject] floatValue];
    }
    for (NSInteger i = 0; i < self.arrayColorsPositions.count; i++)
    {
        CGFloat currentValue = [self.arrayColorsPositions[i] floatValue];
        if (value <= currentValue && i > 0)
        {
            minColorPosition = [self.arrayColorsPositions[i-1] floatValue];
            maxColorPosition = [self.arrayColorsPositions[i] floatValue];
            break;
        }
    }

    CGFloat middleColorPosition = minColorPosition + (maxColorPosition - minColorPosition) / 2;

    return middleColorPosition;
}

- (BOOL)isExistColor:(UIColor *)color
{
    BOOL isExist = NO;
    
    for (NSInteger i = 0; i < self.arrayColors.count; i++)
    {
        if ([color isEqual:self.arrayColors[i]])
        {
            isExist = YES;
            break;
        }
    }
    
    return isExist;
}

- (CGFloat)positionOfColor:(UIColor *)color
{
    NSInteger indexColor = [self.arrayColors indexOfObject:color];
    
    CGFloat minColorPosition = 0;
    CGFloat middleColorPosition = 0;
    CGFloat maxColorPosition = 0;
    
    if (indexColor == self.arrayColorsPositions.count)
    {
        minColorPosition = [self.arrayColorsPositions[indexColor - 1] floatValue];
        maxColorPosition = [self.arrayColorsPositions[indexColor] floatValue];
    }
    else
    {
        minColorPosition = [self.arrayColorsPositions[indexColor] floatValue];
        maxColorPosition = [self.arrayColorsPositions[indexColor + 1] floatValue];
    }
    
    middleColorPosition = minColorPosition + (maxColorPosition - minColorPosition) / 2;
    
    return middleColorPosition;
}

- (UIColor *)colorWithHexValue:(int)hexValue
{
    float red   = ((hexValue & 0xFF0000) >> 16)/255.0;
    float green = ((hexValue & 0xFF00) >> 8)/255.0;
    float blue  = (hexValue & 0xFF)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end

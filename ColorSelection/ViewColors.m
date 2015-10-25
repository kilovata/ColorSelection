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
        self.arrayColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], [UIColor cyanColor], [UIColor magentaColor], [UIColor brownColor]];
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
    return [self colorAtPosition:CGPointMake(value, 5.f)];
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

@end

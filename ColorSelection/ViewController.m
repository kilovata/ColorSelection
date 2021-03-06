//
//  ViewController.m
//  ColorSelection
//
//  Created by Sveta Kilovata on 25/10/15.
//  Copyright © 2015 Sveta Kilovata. All rights reserved.
//

#import "ViewController.h"
#import "ViewColors.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ViewColors *viewColors;
@property (weak, nonatomic) IBOutlet UIView *viewCurrentColor;
@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)chooseColor:(id)sender;
- (IBAction)actionSliderPositionAtCenterOfColor:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self sliderInit];
}

- (void)setupUI
{
    self.viewCurrentColor.layer.cornerRadius = self.viewCurrentColor.frame.size.width/2;
    
    [self.slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateHighlighted];
    [self.slider setMinimumValue:0];
}

- (void)sliderInit
{
    [self.slider setMaximumValue:self.viewColors.frame.size.width-1];

    if ([self.viewColors isExistColor:[UIColor brownColor]])
    {
        self.slider.value = [self.viewColors positionOfColor:[UIColor brownColor]];
    }
    else
    {
        self.slider.value = self.slider.maximumValue / 2 - 1.f;
    }
    self.viewCurrentColor.backgroundColor = [self.viewColors colorWithValue:self.slider.value];
    [self.slider setValue:[self.viewColors recalculateCenterOfColorWithValue:self.slider.value] animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewColors:(UIView *)view currentColor:(UIColor *)color
{
    self.viewCurrentColor.backgroundColor = color;
}

- (IBAction)chooseColor:(id)sender
{
    UISlider *slider = sender;
    self.viewCurrentColor.backgroundColor = [self.viewColors colorWithValue:slider.value];
}

- (IBAction)actionSliderPositionAtCenterOfColor:(id)sender
{
    UISlider *slider = sender;
    [slider setValue:[self.viewColors recalculateCenterOfColorWithValue:slider.value] animated:YES];
}

@end

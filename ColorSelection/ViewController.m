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

    [self.slider setMaximumValue:self.viewColors.frame.size.width-1];
}

- (void)setupUI
{
    self.viewCurrentColor.layer.cornerRadius = self.viewCurrentColor.frame.size.width/2;
    
    [self.slider setThumbImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateHighlighted];
    [self.slider setMinimumValue:0];
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

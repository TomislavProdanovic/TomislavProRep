//
//  ViewController.m
//  CustomSlider
//
//  Created by Tom on 7/22/13.
//  Copyright (c) 2013 Tom. All rights reserved.
//

#import "ViewController.h"
#import "ColorSlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ColorSlider *slider = [[ColorSlider alloc]initWithFrame:CGRectMake(0, 390, 320, 40)];
    slider.minValue = 20;
    slider.maxValue = 85;
	[slider addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}


-(void)newValue:(ColorSlider*)slider{
    self.valueLabel.text = [NSString stringWithFormat:@"%f", slider.selectedValue];
}
@end

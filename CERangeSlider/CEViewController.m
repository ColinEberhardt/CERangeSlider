//
//  CEViewController.m
//  CERangeSlider
//
//  Created by Colin Eberhardt on 22/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "CEViewController.h"
#import "CERangeSlider.h"

@interface CEViewController ()

@end

@implementation CEViewController
{
    CERangeSlider* _rangeSlider;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUInteger margin = 20;
    CGRect sliderFrame = CGRectMake(margin, margin, self.view.frame.size.width - margin * 2, 30);
    _rangeSlider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
    _rangeSlider.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_rangeSlider];
    
    [_rangeSlider addTarget:self
                     action:@selector(slideValueChanged:)
           forControlEvents:UIControlEventValueChanged];
    
}

- (void)slideValueChanged:(id)control
{
    NSLog(@"Slider value changed: (%.2f,%.2f)",
          _rangeSlider.lowerValue, _rangeSlider.upperValue);
}


@end

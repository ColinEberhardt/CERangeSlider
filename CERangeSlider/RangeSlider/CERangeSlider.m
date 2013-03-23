//
//  CERangeSlider.m
//  CERangeSlider
//
//  Created by Colin Eberhardt on 22/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "CERangeSlider.h"
#import <QuartzCore/QuartzCore.h>

@implementation CERangeSlider
{
    CALayer* _trackLayer;
    CALayer* _upperKnobLayer;
    CALayer* _lowerKnobLayer;
    
    float _knobWidth;
    float _useableTrackLength;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _maximumValue = 10.0;
        _minimumValue = 0.0;
        _upperValue = 8.0;
        _lowerValue = 2.0;
        
        _trackLayer = [CALayer layer];
        _trackLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:_trackLayer];
        
        _upperKnobLayer = [CALayer layer];
        _upperKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_upperKnobLayer];
        
        _lowerKnobLayer = [CALayer layer];
        _lowerKnobLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_lowerKnobLayer];
                                           
        [self setLayerFrames];
                                        
    }
    return self;
}
                                           
- (void) setLayerFrames
{
    _trackLayer.frame = CGRectInset(self.bounds, 0, self.bounds.size.height / 3.5);
    [_trackLayer setNeedsDisplay];

    _knobWidth = self.bounds.size.height;
    _useableTrackLength = self.bounds.size.width - _knobWidth;

    float upperKnobCentre = [self positionForValue:_upperValue];
    _upperKnobLayer.frame = CGRectMake(upperKnobCentre - _knobWidth / 2, 0, _knobWidth, _knobWidth);

    float lowerKnobCentre = [self positionForValue:_lowerValue];
    _lowerKnobLayer.frame = CGRectMake(lowerKnobCentre - _knobWidth / 2, 0, _knobWidth, _knobWidth);

    [_upperKnobLayer setNeedsDisplay];
    [_lowerKnobLayer setNeedsDisplay];
}
                                           
- (float) positionForValue:(float)value
{
    return _useableTrackLength * (value - _minimumValue) /
        (_maximumValue - _minimumValue) + (_knobWidth / 2);
}




@end

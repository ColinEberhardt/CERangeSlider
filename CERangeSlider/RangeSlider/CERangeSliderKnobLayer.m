//
//  CERangeSliderKnobLayer.m
//  CERangeSlider
//
//  Created by Colin Eberhardt on 24/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "CERangeSliderKnobLayer.h"
#import "CERangeSlider.h"

@implementation CERangeSliderKnobLayer


- (void)drawInContext:(CGContextRef)ctx
{
    CGRect knobFrame = CGRectInset(self.bounds, 2.0, 2.0);
    
    UIBezierPath *knobPath = [UIBezierPath bezierPathWithRoundedRect:knobFrame
                                                        cornerRadius:knobFrame.size.height * self.slider.curvatiousness / 2.0];
    
    // 1) fill - with a subtle shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1.0, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(ctx, self.slider.knobColour.CGColor);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextFillPath(ctx);
    
    // 2) outline
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextStrokePath(ctx);
    
    
    // 3) inner gradient
    CGRect rect = CGRectInset(knobFrame, 2.0, 2.0);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                        cornerRadius:rect.size.height * self.slider.curvatiousness / 2.0];
    
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 0.0, 0.0, 0.0 , 0.15,  // Start color
        0.0, 0.0, 0.0, 0.05 }; // End color
    
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                                      locations, num_locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, clipPath	.CGPath);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, myGradient, startPoint, endPoint, 0);
    
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(myColorspace);
    CGContextRestoreGState(ctx);
    
    // 4) highlight
    if (self.highlighted)
    {
        // fill
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.1].CGColor);
        CGContextAddPath(ctx, knobPath.CGPath);
        CGContextFillPath(ctx);
    }
}

@end

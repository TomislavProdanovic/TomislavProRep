//
//  ColorSlider.m
//  CustomSlider
//
//  Created by Tom on 7/22/13.
//  Copyright (c) 2013 Tom. All rights reserved.
//

#import "ColorSlider.h"

@implementation ColorSlider


#pragma mark lifecycle

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.opaque = NO;
        
        _currentPoint = CGPointMake(0, 0);
        _minValue = 0;
        _maxValue = 100;
        _radius = self.frame.size.height/2;
        
    }
    
    return self;
}


#pragma mark - tracking

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGPoint lastPoint = [touch locationInView:self];
    lastPoint.x -= _radius;
    
    [self moveHandle:lastPoint];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    
}


#pragma mark - drawing

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect bgRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGContextAddRect(ctx, bgRect);
    [[UIColor colorWithRed:204 green:204 blue:204 alpha:1]setStroke];
  
    CGContextSetLineWidth(ctx, 200);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    CGContextDrawPath(ctx, kCGPathStroke);  
    
    
    CGFloat components[8] = {
        0.0, 0.0, 1.0, 1-_positionPercent/4,    
        1.0, 0.0, 0.0, _positionPercent/4 };
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, components, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGPoint startPoint = CGPointMake(0, CGRectGetMinY(bgRect));
    CGPoint endPoint = CGPointMake(self.frame.size.width, CGRectGetMaxY(bgRect));
    
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    [self drawTheHandle:ctx];
    
}

-(void) drawTheHandle:(CGContextRef)ctx{
    
    CGContextSaveGState(ctx);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2), 5, [UIColor blackColor].CGColor);
    CGPoint handleCenter =  _currentPoint;

    [[UIColor colorWithWhite:1.0 alpha:0.8]set];    
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x, handleCenter.y, _radius * 2, _radius * 2));
    
    CGContextRestoreGState(ctx);
}


-(void)moveHandle:(CGPoint)lastPoint{
    
    Float32 sliderWidth = self.frame.size.width - _radius * 2;
    Float32 point = (lastPoint.x/sliderWidth)*(_maxValue - _minValue) + _minValue;
    
    _selectedValue = point > _maxValue ? _maxValue : point < _minValue ? _minValue : point;
    
    _positionPercent = lastPoint.x / self.frame.size.height;
    
    CGFloat maxRight = sliderWidth;
    CGFloat maxLeft = 0;
    
    _currentPoint = CGPointMake(lastPoint.x > maxRight ? maxRight : lastPoint.x < maxLeft ? maxLeft : lastPoint.x,0);
   
    [self setNeedsDisplay];
}
@end

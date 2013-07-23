//
//  ColorSlider.h
//  CustomSlider
//
//  Created by Tom on 7/22/13.
//  Copyright (c) 2013 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSlider : UIControl{
    CGPoint _currentPoint;
    Float32 _positionPercent;
    Float32 _radius;
}
@property(nonatomic, assign) Float32 minValue;
@property(nonatomic, assign) Float32 maxValue;
@property(nonatomic, assign) Float32 selectedValue;

@end

//
//  CircleChart.h
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/12/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VVChartBeginPoint) {
    VVChartBeginPointTop,
    VVChartBeginPointRight,
    VVChartBeginPointDown,
    VVChartBeginPointLeft
};

typedef NS_ENUM(NSInteger , VVCircleSpeed) {
    VVCircleVeryFast,
    VVCircleFast,
    VVCircleMedium,
    VVCircleSlow
};

@interface CircleChart : UIView

@property CGFloat lineWidth;
@property UIColor *strokeColor;
@property UIColor *fillColor;
@property VVChartBeginPoint startPoint;
@property VVCircleSpeed circleSpeed;
@property BOOL isClockwise;



-(id)initWithFrame:(CGRect)frame;
-(void)DrawArc:(CGFloat)percentToDraw;

@end

//
//  CircleChart.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/12/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//



#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import "CircleChart.h"
#import "UICountingLabel.h"

@implementation CircleChart

CGFloat radius;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lineWidth = 4;
        _strokeColor = [UIColor greenColor];
        _fillColor = [UIColor clearColor];
        _startPoint = VVChartBeginPointTop;
        _isClockwise = YES;
        _circleSpeed = VVCircleVeryFast;
        
        self.frame = frame;
        radius = frame.size.width/2;
    }
    return self;
}

-(void)DrawArc:(CGFloat)percentToDraw
{
    [self drawArc:percentToDraw radius:radius lineWidth:_lineWidth strokeColor:_strokeColor fillColor:_fillColor startPoint: VVChartBeginPointTop isClockwise:_isClockwise circleSpeed:_circleSpeed];
}


-(void)drawArc:(CGFloat )percentToDraw radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor startPoint:(VVChartBeginPoint)startPoint isClockwise:(BOOL)isClockWise circleSpeed:(VVCircleSpeed)circleSpeed;
{
    CGFloat duration;
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    switch (circleSpeed) {
        case VVCircleVeryFast:
            duration = percentToDraw/50;
            break;
        case VVCircleFast:
            duration = percentToDraw/40;
            break;
        case VVCircleMedium:
            duration = percentToDraw/30;
            break;
        case VVCircleSlow:
            duration = percentToDraw/20;
            break;
        default:
            break;
    }
    
    CGFloat startAngle;
    CGFloat endAngle;
    
    switch (startPoint) {
        case VVChartBeginPointTop:
            startAngle = -90.0f;
            endAngle = -90.01f;
            break;
        case VVChartBeginPointRight:
            startAngle = -0.0f;
            endAngle =  -0.1f;
            break;
        case VVChartBeginPointDown:
            startAngle = -270.0f;
            endAngle =  -270.1f;
            break;
        case VVChartBeginPointLeft:
            startAngle = -180.0f;
            endAngle =  -180.1f;
            break;
        default:
            break;
    }
    
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius,radius)  radius:radius startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:isClockWise].CGPath;
    
    //circle.position = CGPointMake(CGRectGetMidX(self.frame)-radius, CGRectGetMidY(self.frame)-radius);
    
    circle.fillColor = fillColor.CGColor;
    circle.strokeColor = strokeColor.CGColor;
    circle.lineWidth = lineWidth;
    circle.strokeEnd = percentToDraw/100;
    circle.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:circle];
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = duration;
    drawAnimation.repeatCount         = 1.0;
    
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:percentToDraw/100];
    
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    // circle label
    UICountingLabel *lblCounting = [[UICountingLabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 60)/2,(self.frame.size.height - 25)/2, 60, 25)];
    [lblCounting countFrom:0 to:percentToDraw withDuration:percentToDraw/40];
    [lblCounting countFromZeroTo:percentToDraw withDuration:duration];
    [lblCounting setTextColor:strokeColor];
    [lblCounting setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [lblCounting setTextAlignment:NSTextAlignmentCenter];
    lblCounting.format = @"%.0f%%";
    [self addSubview:lblCounting];
}







@end

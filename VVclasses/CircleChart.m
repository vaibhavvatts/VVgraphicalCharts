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
        _gradientColor = [UIColor clearColor];
        radius = frame.size.width/2 - 6;
    }
    return self;
}


-(void)setLineWidth:(CGFloat)lineWidth
{
    if (lineWidth > 10) {
        _lineWidth = 10;
    }else if (lineWidth < 1)
    {
        _lineWidth = 1;
    }
}

-(void)DrawArc:(CGFloat)percentToDraw
{
    [self drawArc:percentToDraw radius:radius lineWidth:_lineWidth strokeColor:_strokeColor fillColor:_fillColor startPoint: VVChartBeginPointTop isClockwise:_isClockwise circleSpeed:_circleSpeed gradientColor:_gradientColor];
}


-(void)drawArc:(CGFloat )percentToDraw radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor startPoint:(VVChartBeginPoint)startPoint isClockwise:(BOOL)isClockWise circleSpeed:(VVCircleSpeed)circleSpeed gradientColor:(UIColor *)gradientColor;
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
    
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius+6,radius+6)  radius:radius startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:isClockWise].CGPath;
    
    //circle.position = CGPointMake(CGRectGetMidX(self.frame)-radius, CGRectGetMidY(self.frame)-radius);
    
    circle.fillColor = fillColor.CGColor;
    circle.strokeColor = strokeColor.CGColor;
    circle.lineWidth = lineWidth;
    circle.strokeEnd = percentToDraw/100;
    circle.lineCap = kCALineCapRound;
   
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5,1.0);
    gradientLayer.endPoint = CGPointMake(0.5,0.0);
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
    NSMutableArray *colors = [NSMutableArray array];
    [colors addObject:(id) gradientColor.CGColor];
    [colors addObject:(id)strokeColor.CGColor];
    gradientLayer.colors = colors;
    
    if (_gradientColor != [UIColor clearColor]) {
        [gradientLayer setMask:circle];
        [self.layer addSublayer:gradientLayer];
    }else{
        [self.layer addSublayer:circle];
    }
    
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = duration;
    drawAnimation.repeatCount         = 1.0;
    
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:percentToDraw/100];
    
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    // circle label
    UICountingLabel *lblCounting = [[UICountingLabel alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
    [lblCounting countFrom:0 to:percentToDraw withDuration:percentToDraw/40];
    [lblCounting countFromZeroTo:percentToDraw withDuration:duration];
    [lblCounting setTextColor:strokeColor];
    [lblCounting setFont:[UIFont fontWithName:@"Helvetica-Bold" size:radius/4]];
    [lblCounting setTextAlignment:NSTextAlignmentCenter];
    lblCounting.format = @"%.0f%%";
    [self addSubview:lblCounting];
    
    
    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: duration
                                                  target: (id) self
                                                selector:@selector(callCircleCompleted)
                                                userInfo: nil repeats:NO];
    
    
    
    
    
}


-(void)callCircleCompleted
{
    [self.delegate circleCompleted];
}







@end

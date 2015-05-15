//
//  tmp.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/13/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import "tmp.h"

@implementation tmp


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat arcStartAngle = M_PI;
    CGFloat arcEndAngle = 2 * M_PI;
    
    CGPoint startPoint = CGPointMake(100, 100);
    CGPoint endPoint = CGPointMake(200, 200);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] =
    {
        1.0, 0.0, 0.0, 1.0,   //RGBA values (so red to green in this case)
        0.0, 1.0, 0.0, 1.0
    };

    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    //Where the 2 is for the number of color components. You can have more colors throughout //your gradient by adding to the colors[] array, and changing the components value.
    
    CGColorSpaceRelease(colorSpace);
    
    //Now for the arc part...
    
    CGMutablePathRef arc = CGPathCreateMutable();
    
    CGPathMoveToPoint(arc, NULL, startPoint.x, startPoint.y);
    
    
    //Here, the CGPoint self.arcCenter is the point around which the arc is placed, so maybe the
    //middle of your view. self.radius is the distance between this center point and the arc.
    CGPathAddArc(arc, NULL, self.center.x, self.center.y, 50,
                 arcStartAngle, arcEndAngle, YES);
    
    
    //This essentially draws along the path in an arc shape
    CGPathRef strokedArc = CGPathCreateCopyByStrokingPath(arc, NULL, 5.0f,
                                                          kCGLineCapButt, kCGLineJoinMiter, 10);
    
    
    CGContextSaveGState(context);
    
    CGContextAddPath(context, strokedArc);
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    
}


@end

//
//  LineChart.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/13/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//


#define margin 10

#import "LineChart.h"


@interface LineChart()
{
    NSArray *arrChartData;
    NSMutableArray *plotPoints;
    NSMutableArray *actualPoints;
}

@end

@implementation LineChart


-(id)initWithFrame:(CGRect)frame chartData:(NSArray *)chartData
{
    self = [super initWithFrame:frame];
    if (self) {
        actualPoints = [[NSMutableArray alloc]init];
        arrChartData = [[NSArray alloc]init];
        plotPoints = [[NSMutableArray alloc]init];
        for (arrChartData in chartData) {
            CGFloat max = [[arrChartData valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat min = [[arrChartData valueForKeyPath:@"@min.floatValue"] floatValue];
            for (NSString *strVal in arrChartData) {
                [plotPoints addObject:[NSString stringWithFormat:@"%f",-1 * ((( [strVal floatValue] - min) / (max - min) * 300) - 300)]];
            }
            break;
        }
        [self preparePlotPoints:plotPoints];
    }
    return self;
}

-(void)preparePlotPoints:(NSMutableArray *)plotPoints
{
    int intermediateWidth = 10;
    
    [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth, 300)]];
    for (int i =0; i<10; i++) {
        intermediateWidth += 36;
        [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth,   [[plotPoints objectAtIndex:i] integerValue])]];
    }
    [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth, 300)]];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
//    actualPoints = [[NSArray alloc]initWithObjects:[NSValue valueWithCGPoint:CGPointMake(10, 300)],
//                             [NSValue valueWithCGPoint:CGPointMake(60, 50)],
//                             [NSValue valueWithCGPoint:CGPointMake(110, 300)],nil];
    
    UIBezierPath *path = [[self class] quadCurvedPathWithPoints:actualPoints];
    [[UIColor redColor] setStroke];
    [path stroke];
    [[UIColor redColor] setFill];
    [path fill];
}

+ (UIBezierPath *)quadCurvedPathWithPoints:(NSArray *)points
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSValue *value = points[0];
    CGPoint p1 = [value CGPointValue];
    [path moveToPoint:p1];
    
    if (points.count == 2) {
        value = points[1];
        CGPoint p2 = [value CGPointValue];
        [path addLineToPoint:p2];
        return path;
    }
    
    for (NSUInteger i = 1; i < points.count; i++) {
        value = points[i];
        CGPoint p2 = [value CGPointValue];
        
        CGPoint midPoint = midPointForPoints(p1, p2);
        [path addQuadCurveToPoint:midPoint controlPoint:controlPointForPoints(midPoint, p1)];
        [path addQuadCurveToPoint:p2 controlPoint:controlPointForPoints(midPoint, p2)];
        
        p1 = p2;
    }
    return path;
}

static CGPoint midPointForPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
}

static CGPoint controlPointForPoints(CGPoint p1, CGPoint p2) {
    CGPoint controlPoint = midPointForPoints(p1, p2);
    CGFloat diffY = abs(p2.y - controlPoint.y);
    
    if (p1.y < p2.y)
        controlPoint.y += diffY;
    else if (p1.y > p2.y)
        controlPoint.y -= diffY;
    return controlPoint;
}

@end

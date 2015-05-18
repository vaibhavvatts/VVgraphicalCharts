//
//  LineChart.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/13/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#define width self.bounds.size.width
#define height self.bounds.size.height
#define margin 10

#import "CurvedLineChart.h"


@interface CurvedLineChart()
{
    NSMutableArray *arrChartData;
    NSMutableArray *plotPoints;
    NSMutableArray *actualPoints;
    NSArray *chartTitles;
}

@end

@implementation CurvedLineChart


-(id)initWithFrame:(CGRect)frame chartData:(NSDictionary *)dictChartData
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        _marginAround = 5;
        _lineColor = [UIColor redColor] ;
        _lineWidth = 4;
        _fillColor = [UIColor redColor];
        
        actualPoints = [[NSMutableArray alloc]init];
        arrChartData = [[NSMutableArray alloc]init];
        plotPoints = [[NSMutableArray alloc]init];

        chartTitles = [[dictChartData allKeys] copy];

        for (NSString *title in chartTitles) {
            [arrChartData addObjectsFromArray:[dictChartData valueForKey:title]];
        }

        for (int i =0; i< arrChartData.count; i++) {
                CGFloat max = [[arrChartData valueForKeyPath:@"@max.floatValue"] floatValue];
                CGFloat min = [[arrChartData valueForKeyPath:@"@min.floatValue"] floatValue];
                for (NSString *strVal in arrChartData) {
                    [plotPoints addObject:[NSString stringWithFormat:@"%f",-1 * ((( [strVal floatValue] - min) / (max - min) * height) - height)]];
                }
                break;
        }
        [self preparePlotPoints:plotPoints];
    }
    return self;
}

-(void)preparePlotPoints:(NSMutableArray *)plotPoints
{
    int intermediateWidth = 0;
    
    [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth + _marginAround, height)]];
    for (int i =0; i<arrChartData.count; i++) {
        intermediateWidth += (width / arrChartData.count);
        [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth,   [[plotPoints objectAtIndex:i] integerValue])]];
    }
    [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth, height)]];
}


- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [[self class] quadCurvedPathWithPoints:actualPoints];
    [_lineColor setStroke];
    [path stroke];
    [_fillColor setFill];
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

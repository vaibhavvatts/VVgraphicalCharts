//
//  LineChart.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/18/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#define width self.bounds.size.width
#define height self.bounds.size.height
#define margin 10

#import "LineChart.h"

@interface LineChart()
{
    NSMutableArray *arrChartData;
    NSMutableArray *plotPoints;
    NSMutableArray *actualPoints;
    NSArray *chartTitles;
    
    
    NSMutableArray *arrFinal;
}

@end

@implementation LineChart

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
        arrFinal = [[NSMutableArray alloc]init];
        
        chartTitles = [[dictChartData allKeys] copy];
        
        for (NSString *title in chartTitles) {
            [arrChartData removeAllObjects];
            [arrChartData addObjectsFromArray:[dictChartData valueForKey:title]];
            [plotPoints removeAllObjects];
            for (NSString *strVal in arrChartData) {
                CGFloat max = [[arrChartData valueForKeyPath:@"@max.floatValue"] floatValue];
                CGFloat min = [[arrChartData valueForKeyPath:@"@min.floatValue"] floatValue];
               
                    [plotPoints addObject:[NSString stringWithFormat:@"%f",-1 * ((( [strVal floatValue] - min) / (max - min) * height) - height)]];
                
            }
            [self preparePlotPoints:plotPoints];
        }
    }
    return self;
}

-(void)preparePlotPoints:(NSMutableArray *)plotPoints
{
    int intermediateWidth = 0;
    [actualPoints removeAllObjects];
    [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth + _marginAround, height)]];
    for (int i =0; i<arrChartData.count; i++) {
        intermediateWidth += (width / arrChartData.count);
        [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth,   [[plotPoints objectAtIndex:i] integerValue])]];
    }
    [actualPoints addObject:[NSValue valueWithCGPoint:CGPointMake(intermediateWidth, height)]];
    
    
    [arrFinal addObject:[actualPoints copy]];
    
}

- (void)drawRect:(CGRect)rect {
    [actualPoints removeAllObjects];
    for (int i=0; i<arrFinal.count; i++) {
        [actualPoints removeAllObjects];
        [actualPoints addObjectsFromArray:[[arrFinal objectAtIndex:i] copy]];
        
        UIBezierPath* starPath = UIBezierPath.bezierPath;
        NSValue *value = actualPoints[0];
        CGPoint p1 = [value CGPointValue];
        [starPath moveToPoint:p1];
        
        for (int i=1; i<actualPoints.count; i++) {
            value = actualPoints[i];
            CGPoint p1 = [value CGPointValue];
            [starPath addLineToPoint:p1];
        }
        
        [starPath setLineWidth:_lineWidth] ;
        [_lineColor setStroke];
        [starPath stroke];
        [_fillColor setFill];
        [starPath fill];

        
    }
    
}

@end

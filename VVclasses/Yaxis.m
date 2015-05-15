//
//  Yaxis.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/15/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#define width self.bounds.size.width
#define height self.bounds.size.height

#import "Yaxis.h"


@interface Yaxis()
{
    NSMutableArray *arrPlotData;
    NSArray *arrValues;
}

@end

@implementation Yaxis


-(instancetype)initWithFrame:(CGRect)frame arrValues:(NSArray *)arrValuesReceived
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = 3;
        _marginTRB = 10;
        _lineColor = [UIColor blackColor];
        arrValues = [[NSArray alloc] initWithArray:arrValuesReceived];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawLine];
    
    [self preparePlotValues];
    
    [self plotDashes];
    
    [self plotValues];
}

-(void)drawLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextMoveToPoint(context, width - _marginTRB, _marginTRB);
    CGContextAddLineToPoint(context, width - _marginTRB, height - _marginTRB);
    CGContextStrokePath(context);
}

-(void)plotValues
{
    // plot Labels for figures
    CGFloat intermediateGap = 0.0f;
    for (int i=0; i<arrPlotData.count; i++) {
        UILabel *lblFigure = [[UILabel alloc]initWithFrame:CGRectMake(width - _marginTRB - 60, _marginTRB + intermediateGap - 5, 50, 10)];
        [lblFigure setText:[arrPlotData objectAtIndex:i]];
        [lblFigure setTextColor:_lineColor];
        [lblFigure setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        [lblFigure setTextAlignment:NSTextAlignmentRight];
        //[lblFigure setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:lblFigure];
        
        intermediateGap += (height - 2*_marginTRB) / 10;
    }
}

-(void)plotDashes
{
    // ploting on line.
    CGFloat intermediateGap;
    for (int i=0; i<arrPlotData.count; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(width - _marginTRB - 5, _marginTRB + intermediateGap)];
        [path addLineToPoint:CGPointMake(width - _marginTRB + 5, _marginTRB + intermediateGap)];
        path.lineWidth = _lineWidth - 1;
        [_lineColor setStroke];
        [path stroke];
        
        intermediateGap += (height - 2*_marginTRB) / 10;
    }
}

-(void)preparePlotValues
{
    arrPlotData = [[NSMutableArray alloc]init];
    
    CGFloat maxVal = [[arrValues valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minVal = [[arrValues valueForKeyPath:@"@min.floatValue"] floatValue];
    
    NSMutableArray * arrIntermediateVal = [[NSMutableArray alloc]init];
    
    
    CGFloat factor = (maxVal - minVal)/arrValues.count;
    for (int i =1; i<=arrValues.count; i++) {
        [arrIntermediateVal addObject:[NSString stringWithFormat:@"%f",(minVal + factor * i)]];
    }
    
    
    for (NSString *digitStr in arrIntermediateVal) {
        ;
        
        [self formatDigits:(uint)[[[digitStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]] firstObject] length] data:digitStr];
    }
    
}



-(void)formatDigits:(int)digits data:(NSString *)dataStr
{
    switch (digits) {
        case 1:
            // go min -> 0
            [arrPlotData addObject:[NSString stringWithFormat:@"0"]];
            break;
        case 2:
            // reach -> one zero at unit place
            //[self formatNumber:dataStr];
            [arrPlotData addObject:[NSString stringWithFormat:@"%@",[dataStr substringToIndex:2]]];
            break;
        case 3:
            // reach -> two zero at unit place
            [arrPlotData addObject:[NSString stringWithFormat:@"%@K",[dataStr substringToIndex:1]]];
            break;
        case 4:
            [arrPlotData addObject:[NSString stringWithFormat:@"%@K",[dataStr substringToIndex:1]]];
            break;
        case 5 :
            [arrPlotData addObject:[NSString stringWithFormat:@"%@K",[dataStr substringToIndex:2]]];
            break;
        case 6:
            [arrPlotData addObject:[NSString stringWithFormat:@"%@K",[dataStr substringToIndex:3]]];
            break;
        case 7:
            [arrPlotData addObject:[NSString stringWithFormat:@"%@L",[dataStr substringToIndex:2]]];
            break;
        case 8:
            [arrPlotData addObject:[NSString stringWithFormat:@"%@M",[dataStr substringToIndex:2]]];
            break;
        default:
            break;
    }
}

-(int)formatNumber:(NSString *)number
{
    return 1;
}
@end

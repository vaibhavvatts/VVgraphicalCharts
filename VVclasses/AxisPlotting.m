//
//  Xaxis.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/15/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//


#define width self.bounds.size.width
#define height self.bounds.size.height

#import "AxisPlotting.h"

@interface AxisPlotting()
{
    NSMutableArray *arrPlotData;
    NSArray *arrValues;
    
}

@end
@implementation AxisPlotting


-(instancetype)initWithFrame:(CGRect)frame arrValues:(NSArray *)arrValuesReceived dataFormat:(VVdataFormat)dataFormat axisType:(VVaxisType)axisType
{
    self = [super initWithFrame:frame];
    if (self) {
        // default properties
        _lineWidth = 3;
        _margin = 14;
        _lineColor = [UIColor blackColor];
        _dashColor = [UIColor blackColor];
        _textColor = [UIColor blackColor];
        _textSize = 10;
        _numberOfDashes = (uint)arrValuesReceived.count;
        _axisType = axisType;

        arrValues = [[NSArray alloc] initWithArray:arrValuesReceived];
        arrPlotData = [[NSMutableArray alloc]init];

        [self setBackgroundColor:[UIColor whiteColor]];

        if (dataFormat == VVdataFormatNumeric) {
            [self prepareNumericPlotValues];
        }else if (dataFormat == VVdataFormatStatic){
            arrPlotData = [arrValuesReceived copy];
        }

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawLine];
    [self plotDashes];
    [self plotValues];
}

-(void)loadXaxis
{
    [self setNeedsDisplay];
}

-(void)drawLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    if (_axisType == VVaxisTypeHorizontal) {
        CGContextMoveToPoint(context, _margin,  _margin) ;
        CGContextAddLineToPoint(context, width - _margin, _margin); 

    }else if (_axisType == VVaxisTypeVertical){
        CGContextMoveToPoint(context, width - _margin, _margin);
        CGContextAddLineToPoint(context, width - _margin, height - _margin);
    }
    CGContextStrokePath(context);
    
    //CGContextFlush(context);
}

-(void)plotValues
{
    UILabel *lblFigure;
    CGFloat intermediateGap = 0.0f;

    for (int i=0; i<_numberOfDashes; i++) {
        if (_axisType == VVaxisTypeHorizontal) {
            lblFigure = [[UILabel alloc]initWithFrame:CGRectMake(_margin + intermediateGap - 5 , _margin  + 10, 50, 10)];
            intermediateGap += (width - 2*_margin) / (_numberOfDashes - 1);
            [lblFigure setTextAlignment:NSTextAlignmentLeft];
        }else if (_axisType == VVaxisTypeVertical){
            lblFigure = [[UILabel alloc]initWithFrame:CGRectMake(width - _margin - 60, _margin + intermediateGap - 5, 50, 10)];
            intermediateGap += (height - 2*_margin) / (_numberOfDashes - 1);
            [lblFigure setTextAlignment:NSTextAlignmentRight];
        }
        [lblFigure setText:[arrPlotData objectAtIndex:i]];
        [lblFigure setTextColor:_textColor];
        [lblFigure setFont:[UIFont fontWithName:@"Helvetica" size:_textSize]];

        [self addSubview:lblFigure];
    }
}

-(void)plotDashes
{
    // ploting on line.
    CGFloat intermediateGap = 0;
    CGFloat eitherGap = 0.0f;
    for (int i=0; i<_numberOfDashes; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];

        if (i==0) {
            eitherGap = 1;
        }else if (i == arrPlotData.count -1 ){
            eitherGap = -1;
        }else{
            eitherGap = 0;
        }

        if (_axisType == VVaxisTypeHorizontal) {
            [path moveToPoint:CGPointMake(_margin + intermediateGap + eitherGap, _margin - 5)];
            [path addLineToPoint:CGPointMake(_margin + intermediateGap + eitherGap , _margin + 5)];
            intermediateGap += (width - 2*_margin) / (_numberOfDashes - 1);
        }else if (_axisType == VVaxisTypeVertical){
            [path moveToPoint:CGPointMake(width - _margin - 5, _margin + intermediateGap)];
            [path addLineToPoint:CGPointMake(width - _margin + 5, _margin + intermediateGap)];
            intermediateGap += (height - 2*_margin) / (_numberOfDashes -1);
        }
        path.lineWidth = _lineWidth - 1;
        [_lineColor setStroke];
        [path stroke];

    }
}

-(void)prepareNumericPlotValues
{
    CGFloat maxVal = [[arrValues valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat minVal = [[arrValues valueForKeyPath:@"@min.floatValue"] floatValue];
    
    NSMutableArray * arrIntermediateVal = [[NSMutableArray alloc]init];
    
    
    CGFloat factor = (maxVal - minVal)/_numberOfDashes;
    for (int i =1; i<=_numberOfDashes; i++) {
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

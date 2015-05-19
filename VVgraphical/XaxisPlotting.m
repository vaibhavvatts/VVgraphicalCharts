//
//  GraphView.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 16/05/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//


#define ARC4RANDOM_MAX 0x100000000

#import "XaxisPlotting.h"
#import "AxisPlotting.h"

@interface XaxisPlotting()
{
    UIScrollView *scrollView;
    NSArray *chartData;
    NSMutableArray *mutableChartData;
}

@end

@implementation XaxisPlotting


-(void)awakeFromNib
{
    scrollView = [[UIScrollView alloc]init];
    [scrollView setBackgroundColor:[UIColor yellowColor]];
    [scrollView setBounces:NO];
    [self addSubview:scrollView];
}


-(void)layoutSubviews
{
    [self setNeedsDisplay  ];
    [scrollView setFrame:CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-10)];
    [self setupGraph];
    
}


-(void)setupGraph
{
    [self initFakeData];
    AxisPlotting *yAxis = [[AxisPlotting alloc]initWithFrame:CGRectMake(0, 10, 500, 80) arrValues:mutableChartData dataFormat:VVdataFormatNumeric axisType:VVaxisTypeHorizontal];
    [scrollView setContentSize:CGSizeMake(500, 80)];
    [scrollView addSubview:yAxis];
    [scrollView setScrollEnabled:YES];
    //[scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, 600)];
}

-(void)getRef:(GraphPlotting *)refGraphPlotting
{
    
}

- (void)initFakeData
{
    NSMutableArray *mutableLineCharts = [NSMutableArray array];
    for (int lineIndex=0; lineIndex<2; lineIndex++)
    {
        mutableChartData = [NSMutableArray array];
        for (int i=0; i<11; i++)
        {
            [mutableChartData addObject:[NSNumber numberWithFloat:((double)arc4random() / ARC4RANDOM_MAX) * 66879652]];
        }
        [mutableLineCharts addObject:mutableChartData];
    }
    chartData = [NSArray arrayWithArray:mutableLineCharts];

}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

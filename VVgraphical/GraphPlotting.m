//
//  GraphPlotting.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/18/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#define chartWidth 500

#define ARC4RANDOM_MAX 0x100000000

#import "GraphPlotting.h"

#import "CurvedLineChart.h"


@interface GraphPlotting()<UIScrollViewDelegate>
{
  
    UIScrollView *scrollView;
    NSMutableArray *arrData;
    NSMutableDictionary *chartData;
    NSMutableArray *mutableChartData;
    
  
}

@end

@implementation GraphPlotting

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate graphDidScroll:scrollView.contentOffset.x];
}

-(void)setupGraph
{
        [self initFakeData];
    CurvedLineChart *chart = [[CurvedLineChart alloc]initWithFrame:CGRectMake(0, 0, chartWidth, scrollView.bounds.size.height - 5) chartData:chartData];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(chartWidth, scrollView.bounds.size.height - 5)];
    //[chart setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.5]];
    [scrollView addSubview:chart];
    

//    CurvedLineChart *chart2 = [[CurvedLineChart alloc]initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width - 5, scrollView.bounds.size.height - 5) chartData:chartData];
//    [scrollView setScrollEnabled:YES];
//    [chart2 setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.5]];
//    [scrollView addSubview:chart2];
    
    //[scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, 600)];
}


- (void)initFakeData
{
    NSMutableArray *mutableLineCharts = [NSMutableArray array];
    for (int lineIndex=0; lineIndex<1; lineIndex++)
    {
        mutableChartData = [NSMutableArray array];
        for (int i=0; i<10; i++)
        {
            [mutableChartData addObject:[NSNumber numberWithFloat:((double)arc4random() / ARC4RANDOM_MAX) * 66879652]];
        }
        [mutableLineCharts addObject:mutableChartData];
    }
        chartData = [[NSMutableDictionary alloc]initWithObjects:mutableLineCharts forKeys:[[NSArray alloc]initWithObjects:@"ChartTitleOne", nil]];
    
    //[chartData setObject:mutableChartData forKeyedSubscript:@"ChartTitleTwo"];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

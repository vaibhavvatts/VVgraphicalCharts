//
//  ViewController.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/12/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//



#define ARC4RANDOM_MAX 0x100000000

#import "ViewController.h"
#import "CircleChart.h"

#import "CurvedLineChart.h"
#import "LineChart.h"

#import "AxisPlotting.h"



@interface ViewController ()
{
    NSMutableArray *arrData;
    NSMutableDictionary *chartData;
    NSMutableArray *mutableChartData;
    
    __weak IBOutlet UIView *graphView;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    chartData = [[NSMutableDictionary alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CircleChart *cc = [[CircleChart alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
//    [cc setStrokeColor:[UIColor redColor]];
//    [cc setLineWidth:8];
//    [cc setGradientColor:[UIColor blackColor]];
//    cc.delegate = self;
//    [cc DrawArc:90];
//    [self.view addSubview:cc];
    
    
//    [self initFakeData];
//    
//    LineChart *lineChart = [[LineChart alloc]initWithFrame:CGRectMake(0, 0, graphView.frame.size.width, graphView.bounds.size.height) chartData:chartData];
//    [graphView addSubview:lineChart];


    // fakeStaticData
//    [mutableChartData removeAllObjects];
//    for (int i =0; i< 3; i++) {
//        [mutableChartData addObject:@"sun"];
//    }

//    AxisPlotting *xaxis = [[AxisPlotting alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 100) arrValues:mutableChartData dataFormat:VVdataFormatNumeric axisType:VVaxisTypeVertical];
//    [xaxis setBackgroundColor:[UIColor yellowColor]];
//    [xaxis setNumberOfDashes:6];
//    [self.view addSubview:xaxis];
    

    [xAxisObj getRef:graphObj];
    
    [graphView layoutIfNeeded];
    [self initFakeData];
    
    LineChart *lineChart = [[LineChart alloc]initWithFrame:CGRectMake(0, 0, graphView.frame.size.width, graphView.bounds.size.height) chartData:chartData];
    [lineChart setFillColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.5]];
    [lineChart setLineColor:[[UIColor darkGrayColor] colorWithAlphaComponent:.5]];
    [lineChart setLineWidth:6];
    [graphView addSubview:lineChart];
    NSLog(@"%f",graphView.frame.size.width);
}

- (void)initFakeData
{
    NSMutableArray *mutableLineCharts = [NSMutableArray array];
    for (int lineIndex=0; lineIndex<2; lineIndex++)
    {
        mutableChartData = [NSMutableArray array];
        for (int i=0; i<10; i++)
        {
            [mutableChartData addObject:[NSNumber numberWithFloat:((double)arc4random() / ARC4RANDOM_MAX) * 500]];
        }
        [mutableLineCharts addObject:mutableChartData];
        
        [chartData setObject:mutableChartData forKeyedSubscript:[NSString stringWithFormat:@"%f",(double)arc4random() / ARC4RANDOM_MAX]];
    }

    

}


-(void)formatDigits:(int)digits data:(NSString *)dataStr
{
    switch (digits) {
        case 4:
            [arrData addObject:[NSString stringWithFormat:@"%@K",[dataStr substringToIndex:1]]];
            break;
        case 5 :
            [arrData addObject:[NSString stringWithFormat:@"%@K",[dataStr substringToIndex:2]]];
            break;
        case 6:
            [arrData addObject:[NSString stringWithFormat:@"%@K",[dataStr substringToIndex:3]]];
            break;
        case 7:
            [arrData addObject:[NSString stringWithFormat:@"%@L",[dataStr substringToIndex:2]]];
            break;
        case 8:
            [arrData addObject:[NSString stringWithFormat:@"%@M",[dataStr substringToIndex:2]]];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

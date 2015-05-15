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

#import "LineChart.h"
#import "Yaxis.h"

#import "Xaxis.h"



@interface ViewController ()
{
    NSMutableArray *arrData;
    NSArray *chartData;
    NSMutableArray *mutableChartData;
    
    
    __weak IBOutlet UIView *subView;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrlView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CircleChart *cc = [[CircleChart alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
//    [cc setStrokeColor:[UIColor redColor]];
//    [cc setLineWidth:8];
//    [cc setGradientColor:[UIColor blackColor]];
//    cc.delegate = self;
//    [cc DrawArc:90];
//    [self.view addSubview:cc];
    
    
    // data sampling
//    arrData = [[NSMutableArray alloc]init];
//    
//    int minVal = 80;
//    int maxVal = 58744325;
//    
//    NSMutableArray * arrIntermediateVal = [[NSMutableArray alloc]init];
//
    
//    int factor = (maxVal - minVal)/10;
//    for (int i =1; i<=10; i++) {
//        [arrIntermediateVal addObject:[NSString stringWithFormat:@"%d",(minVal + factor * i)]];
//    }
//    
//    
//    for (NSString *digitStr in arrIntermediateVal) {
//        [self formatDigits:(uint)[digitStr length] data:digitStr];
//    }
//    
//    NSLog(@"%@",arrData);

    
    
//    
//    NSArray *points = [[NSArray alloc]initWithObjects:NSStringFromCGPoint(CGPointMake(10, 20)), nil];
//    NSValue *value = points[0];
//    CGPoint p1 = [value CGPointValue];
    
//    [self initFakeData];
//    
//    LineChart *lineChart = [[LineChart alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) chartData:chartData];
//    [self.view addSubview:lineChart];
    
    [self initFakeData];
    
    Xaxis *xaxis = [[Xaxis alloc]initWithFrame:CGRectMake(0, 50, 300, 100) arrValues:mutableChartData];
    [xaxis setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:xaxis];
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

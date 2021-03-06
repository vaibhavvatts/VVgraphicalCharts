//
//  ViewController.m
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/12/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import "ViewController.h"
#import "CircleChart.h"



@interface ViewController ()<VVCircleChartProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CircleChart *cc = [[CircleChart alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    [cc setStrokeColor:[UIColor redColor]];
    [cc setLineWidth:15];
    [cc setGradientColor:[UIColor blackColor]];
    cc.delegate = self;
    [cc DrawArc:90];
    [self.view addSubview:cc];

}

-(void)circleCompleted
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

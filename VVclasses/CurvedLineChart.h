//
//  LineChart.h
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/13/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurvedLineChart : UIView


@property CGFloat marginAround;
@property CGFloat lineWidth;
@property UIColor *lineColor;
@property UIColor *fillColor;


-(id)initWithFrame:(CGRect)frame chartData:(NSDictionary *)dictChartData;

@end

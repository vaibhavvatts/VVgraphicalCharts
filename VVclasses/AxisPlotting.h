//
//  Xaxis.h
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/15/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VVdataFormat) {
    VVdataFormatNumeric,
    VVdataFormatStatic
};

typedef NS_ENUM(NSInteger, VVaxisType) {
    VVaxisTypeHorizontal,
    VVaxisTypeVertical
};


@interface AxisPlotting : UIView

@property CGFloat lineWidth;
@property CGFloat margin;
@property UIColor *lineColor;
@property UIColor *dashColor;
@property UIColor *textColor;
@property CGFloat textSize;
@property int numberOfDashes;
@property VVaxisType axisType;


-(void)loadXaxis;
-(instancetype)initWithFrame:(CGRect)frame arrValues:(NSArray *)arrValuesReceived dataFormat:(VVdataFormat)dataFormat  axisType:(VVaxisType)axisType;




@end

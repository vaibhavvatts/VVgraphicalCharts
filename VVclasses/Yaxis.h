//
//  Yaxis.h
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/15/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Yaxis : UIView

@property CGFloat lineWidth;
@property CGFloat marginTRB;
@property UIColor *lineColor;



-(instancetype)initWithFrame:(CGRect)frame arrValues:(NSArray *)arrValuesReceived;


@end

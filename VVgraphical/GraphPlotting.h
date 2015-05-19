//
//  GraphPlotting.h
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/18/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphScrollProtocol <NSObject>

-(void)graphDidScroll:(CGFloat)xPoint;

@end

@interface GraphPlotting : UIView


@property (weak, nonatomic) id <GraphScrollProtocol> delegate;

@end

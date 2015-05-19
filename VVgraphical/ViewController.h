//
//  ViewController.h
//  VVgraphical
//
//  Created by Vaibhav Kumar on 5/12/15.
//  Copyright (c) 2015 OpenSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphPlotting.h"
#import "XaxisPlotting.h"

@interface ViewController : UIViewController


{
    IBOutlet GraphPlotting *graphObj;
    IBOutlet XaxisPlotting *xAxisObj;
}

@end


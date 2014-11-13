//
//  HDChartLabel.m
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "HDChartLabel.h"

@implementation HDChartLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        self.font = [UIFont boldSystemFontOfSize:11.0f];
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.minimumScaleFactor = [[UIScreen mainScreen] scale];
        self.adjustsFontSizeToFitWidth = YES;
    }

    return self;
}

@end

//
//  HDCurveChartData.m
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "HDCurveChartData.h"

@implementation HDCurveChartData

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setDefaultValues];
    }
    return self;
}

- (void)setDefaultValues
{
    _linColor = [UIColor colorWithRed:0.000 green:0.671 blue:0.953 alpha:1];
    _lineWidth = 1.0f;
    _points = [NSMutableArray array];
}
@end

//
//  HDCurveChartDataItem.m
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "HDCurveChartDataItem.h"

@interface HDCurveChartDataItem ()

@property (nonatomic, assign, readwrite) CGFloat x;
@property (nonatomic, assign, readwrite) CGFloat y;

@end

@implementation HDCurveChartDataItem

- (id)initWithX:(CGFloat)x withY:(CGFloat)y
{
    self = [super init];
    if (self)
    {
        self.x = x;
        self.y = y;
    }
    return self;
}

+ (HDCurveChartDataItem *)dataItemWithX:(CGFloat)x withY:(CGFloat)y;
{
    return [[HDCurveChartDataItem alloc] initWithX:x withY:y];
}

@end

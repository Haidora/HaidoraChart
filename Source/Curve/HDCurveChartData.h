//
//  HDCurveChartData.h
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDCurveChartDataItem.h"

typedef NS_ENUM(NSUInteger, HDChartPointStyle)
{
    HDChartPointStyleNone = 0,
    HDChartPointStyleCycle,
    HDChartPointStyleTriangle,
    HDChartPointStyleSquare
};

typedef NS_ENUM(NSUInteger, HDChartStyle)
{
    HDChartStyleLine = 0,
    HDChartStyleCurve
};

@interface HDCurveChartData : NSObject

@property (nonatomic, strong) UIColor *linColor;
@property (nonatomic, strong) NSString *lineTitle;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) HDChartStyle chartStyle;
//@property (nonatomic, assign) HDChartPointStyle chartPointStyle;

@property (nonatomic, strong) NSMutableArray *points;

@end

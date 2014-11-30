//
//  HDCurveChart.h
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HDCurveChartData.h"

@interface HDCurveChart : UIView

#pragma mark
#pragma mark ChartConfig

@property (nonatomic, assign) CGFloat chartMargin;

@property (nonatomic, assign) CGFloat xValueMax;
@property (nonatomic, assign) CGFloat xValueMin;
@property (nonatomic, assign) NSInteger xStepNum;
/**
 *  rect fill Period(fill size is xPeriodFillNum/2)
 */
@property (nonatomic, assign) NSInteger xPeriodFillNum;
@property (nonatomic, copy) BOOL (^xShowGraduation)(NSInteger index);
@property (nonatomic, copy) BOOL (^xShowLabel)(NSInteger index);
@property (nonatomic, copy) NSString * (^getXLabel)(NSInteger index);

@property (nonatomic, assign) CGFloat yValueMax;
@property (nonatomic, assign) CGFloat yValueMin;
@property (nonatomic, assign) NSInteger yStepNum;
@property (nonatomic, copy) BOOL (^yShowGraduation)(NSInteger index);
@property (nonatomic, copy) BOOL (^yShowLabel)(NSInteger index);
@property (nonatomic, copy) NSString * (^getYLabel)(NSInteger index);

// used
@property (nonatomic, assign) BOOL showCoordinateAxis;
@property (nonatomic, assign) CGFloat axisWidth;
@property (nonatomic, strong) UIColor *axisColor;

#pragma mark
#pragma mark Datas

@property (nonatomic, strong) NSArray *chartDatas;

@end

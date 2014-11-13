//
//  HDCurveChartDataItem.h
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HDCurveChartDataItem : NSObject

@property (nonatomic, assign, readonly) CGFloat x;
@property (nonatomic, assign, readonly) CGFloat y;

+ (HDCurveChartDataItem *)dataItemWithX:(CGFloat)x withY:(CGFloat)y;

@end

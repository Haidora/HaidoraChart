//
//  ViewController.m
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "ViewController.h"
#import "HDCurveChart.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet HDCurveChart *chartView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _chartView.yValueMin = 45;
    _chartView.yValueMax = 120;
    _chartView.yStepNum = _chartView.yValueMax - _chartView.yValueMin;
    _chartView.xShowLabel = ^(NSInteger index) {
        if (index % 12 == 0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    };
    _chartView.getXLabel = ^(NSInteger index) { return [NSString stringWithFormat:@"%ld年", index]; };

    _chartView.yShowLabel = ^(NSInteger index) {
        if (index % 5 == 0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
        return YES;
    };
    _chartView.getYLabel =
        ^(NSInteger index) { return [NSString stringWithFormat:@"%ld", index + 45]; };

    // curve 1
    HDCurveChartData *data1 = [[HDCurveChartData alloc] init];
    data1.chartStyle = HDChartStyleCurve;
    //    HDCurveChartDataItem *item = [HDCurveChartDataItem dataItemWithX:0 withY:48.2];
    //    [data1.points addObject:item];
    //    item = [HDCurveChartDataItem dataItemWithX:7 withY:18.9];
    //    [data1.points addObject:item];
    //    item = [HDCurveChartDataItem dataItemWithX:8 withY:19.9];
    //    [data1.points addObject:item];
    //    item = [HDCurveChartDataItem dataItemWithX:9 withY:21.0];
    //    [data1.points addObject:item];
    //    item = [HDCurveChartDataItem dataItemWithX:10 withY:22.1];
    //    [data1.points addObject:item];
    //    item = [HDCurveChartDataItem dataItemWithX:11 withY:23.3];
    //    [data1.points addObject:item];
    NSArray *datas = [NSArray arrayWithObjects:@{ @"x" : @(0),
                                                  @"y" : @(48.2) },
                                               @{ @"x" : @(1),
                                                  @"y" : @(52.1) },
                                               @{ @"x" : @(2),
                                                  @"y" : @(55) },
                                               @{ @"x" : @(3),
                                                  @"y" : @(58) },
                                               @{ @"x" : @(4),
                                                  @"y" : @(61) },
                                               @{ @"x" : @(5),
                                                  @"y" : @(62) },
                                               @{ @"x" : @(6),
                                                  @"y" : @(65) },
                                               @{ @"x" : @(7),
                                                  @"y" : @(67) },
                                               @{ @"x" : @(8),
                                                  @"y" : @(68) },
                                               @{ @"x" : @(9),
                                                  @"y" : @(70) },
                                               @{ @"x" : @(10),
                                                  @"y" : @(71) },
                                               @{ @"x" : @(11),
                                                  @"y" : @(72) },
                                               @{ @"x" : @(12),
                                                  @"y" : @(73) },
                                               @{ @"x" : @(24),
                                                  @"y" : @(84) },
                                               @{ @"x" : @(36),
                                                  @"y" : @(91) },
                                               @{ @"x" : @(48),
                                                  @"y" : @(99) },
                                               @{ @"x" : @(60),
                                                  @"y" : @(105) },
                                               nil];

    [datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = obj;
        HDCurveChartDataItem *item = [HDCurveChartDataItem dataItemWithX:[dic[@"x"] doubleValue]
                                                                   withY:[dic[@"y"] doubleValue]];
        [data1.points addObject:item];
    }];

    // curve 1
    //    HDCurveChartData *data2 = [[HDCurveChartData alloc] init];
    //    data2.chartStyle = HDChartStyleLine;
    //    CGFloat margin2 = 0;
    //
    //    HDCurveChartDataItem *item2 = [HDCurveChartDataItem dataItemWithX:0 withY:0];
    //    [data2.points addObject:item2];
    //    item2 = [HDCurveChartDataItem dataItemWithX:12 + margin2 withY:5 - margin2];
    //    [data2.points addObject:item2];
    //    item2 = [HDCurveChartDataItem dataItemWithX:20 + margin2 withY:10 - margin2];
    //    [data2.points addObject:item2];
    //    item2 = [HDCurveChartDataItem dataItemWithX:36 + margin2 withY:25 - margin2];
    //    [data2.points addObject:item2];
    //    item2 = [HDCurveChartDataItem dataItemWithX:48 + margin2 withY:45 - margin2];
    //    [data2.points addObject:item2];
    //    item2 = [HDCurveChartDataItem dataItemWithX:60 + margin2 withY:50 - margin2];
    //    [data2.points addObject:item2];

    _chartView.chartDatas = @[ data1 ];

    //    [_chartView strokeChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
    _chartView.xValueMin = 0;
    _chartView.xValueMax = 120;
    _chartView.xStepNum = 120;
    _chartView.xPeriodFillNum = 12;
    _chartView.xShowGraduation = ^(NSInteger index)
    {
        if(index<12)
        {
            return YES;
        }
        
        if (index%12==0)
        {
            return YES;
        }
        return NO;
    };
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
    _chartView.getXLabel = ^(NSInteger index) { return [NSString stringWithFormat:@"%ld", index]; };

    _chartView.yValueMin = 0;
    _chartView.yValueMax = 40;
    _chartView.yStepNum = 40;
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
    _chartView.getYLabel = ^(NSInteger index) { return [NSString stringWithFormat:@"%ld", index]; };

    // curve 1
    HDCurveChartData *data1 = [[HDCurveChartData alloc] init];
    data1.chartStyle = HDChartStyleLine;
    NSArray *datas = [NSArray arrayWithObjects:@{ @"x" : @(1.0),
                                                  @"y" : @(3.6) },
                                               @{ @"x" : @(2.0),
                                                  @"y" : @(4.3) },
                                               @{ @"x" : @(3.0),
                                                  @"y" : @(5.0) },
                                               @{ @"x" : @(4.0),
                                                  @"y" : @(5.7) },
                                               @{ @"x" : @(5.0),
                                                  @"y" : @(6.3) },
                                               @{ @"x" : @(6.0),
                                                  @"y" : @(6.9) },
                                               @{ @"x" : @(8.0),
                                                  @"y" : @(7.8) },
                                               @{ @"x" : @(10.0),
                                                  @"y" : @(8.6) },
                                               @{ @"x" : @(12.0),
                                                  @"y" : @(9.1) },
                                               @{ @"x" : @(15.0),
                                                  @"y" : @(9.8) },
                                               @{ @"x" : @(18.0),
                                                  @"y" : @(10.3) },
                                               @{ @"x" : @(21.0),
                                                  @"y" : @(10.8) },
                                               @{ @"x" : @(24.0),
                                                  @"y" : @(11.2) },
                                               @{ @"x" : @(30.0),
                                                  @"y" : @(12.1) },
                                               @{ @"x" : @(36.0),
                                                  @"y" : @(13.0) },
                                               @{ @"x" : @(42.0),
                                                  @"y" : @(13.9) },
                                               @{ @"x" : @(48.0),
                                                  @"y" : @(14.8) },
                                               @{ @"x" : @(54.0),
                                                  @"y" : @(15.7) },
                                               @{ @"x" : @(60.0),
                                                  @"y" : @(16.6) },
                                               @{ @"x" : @(66.0),
                                                  @"y" : @(17.4) },
                                               @{ @"x" : @(72.0),
                                                  @"y" : @(18.4) },
                                               @{ @"x" : @(84.0),
                                                  @"y" : @(20.2) },
                                               @{ @"x" : @(96.0),
                                                  @"y" : @(22.2) },
                                               @{ @"x" : @(108.0),
                                                  @"y" : @(24.3) },
                                               @{ @"x" : @(120.0),
                                                  @"y" : @(26.8) },
                                               nil];

    [datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = obj;
        HDCurveChartDataItem *item = [HDCurveChartDataItem dataItemWithX:[dic[@"x"] doubleValue]
                                                                   withY:[dic[@"y"] doubleValue]];
        [data1.points addObject:item];
    }];

    // curve 1
    HDCurveChartData *data2 = [[HDCurveChartData alloc] init];
    data2.chartStyle = HDChartStyleLine;
    NSArray *dataE = [NSArray arrayWithObjects:@{ @"x" : @(1.0),
                                                  @"y" : @(5.0) },
                                               @{ @"x" : @(2.0),
                                                  @"y" : @(6.0) },
                                               @{ @"x" : @(3.0),
                                                  @"y" : @(6.9) },
                                               @{ @"x" : @(4.0),
                                                  @"y" : @(7.6) },
                                               @{ @"x" : @(5.0),
                                                  @"y" : @(8.2) },
                                               @{ @"x" : @(6.0),
                                                  @"y" : @(8.8) },
                                               @{ @"x" : @(8.0),
                                                  @"y" : @(9.8) },
                                               @{ @"x" : @(10.0),
                                                  @"y" : @(10.6) },
                                               @{ @"x" : @(12.0),
                                                  @"y" : @(11.3) },
                                               @{ @"x" : @(15.0),
                                                  @"y" : @(12.0) },
                                               @{ @"x" : @(18.0),
                                                  @"y" : @(12.7) },
                                               @{ @"x" : @(21.0),
                                                  @"y" : @(13.3) },
                                               @{ @"x" : @(24.0),
                                                  @"y" : @(14.0) },
                                               @{ @"x" : @(30.0),
                                                  @"y" : @(15.3) },
                                               @{ @"x" : @(36.0),
                                                  @"y" : @(16.4) },
                                               @{ @"x" : @(42.0),
                                                  @"y" : @(17.6) },
                                               @{ @"x" : @(48.0),
                                                  @"y" : @(18.7) },
                                               @{ @"x" : @(54.0),
                                                  @"y" : @(19.9) },
                                               @{ @"x" : @(60.0),
                                                  @"y" : @(21.1) },
                                               @{ @"x" : @(66.0),
                                                  @"y" : @(22.3) },
                                               @{ @"x" : @(72.0),
                                                  @"y" : @(23.6) },
                                               @{ @"x" : @(84.0),
                                                  @"y" : @(26.5) },
                                               @{ @"x" : @(96.0),
                                                  @"y" : @(30.0) },
                                               @{ @"x" : @(108.0),
                                                  @"y" : @(34.0) },
                                               @{ @"x" : @(120.0),
                                                  @"y" : @(38.7) },
                                               nil];

    [dataE enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = obj;
        HDCurveChartDataItem *item = [HDCurveChartDataItem dataItemWithX:[dic[@"x"] doubleValue]
                                                                   withY:[dic[@"y"] doubleValue]];
        [data2.points addObject:item];
    }];

    _chartView.chartDatas = @[ data1, data2 ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

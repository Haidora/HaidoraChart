//
//  HDCurveChart.m
//  HaidoraChart
//
//  Created by DaiLingChi on 14-11-6.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "HDCurveChart.h"
#import "HDChartLabel.h"

@interface HDCurveChart ()

@property (nonatomic, assign) CGFloat chartCavanHeight;
@property (nonatomic, assign) CGFloat chartCavanWidth;

@property (nonatomic, strong) NSMutableArray *chartLineArray;
@property (nonatomic, strong) NSMutableArray *chartPointArray;

@property (nonatomic, strong) NSMutableArray *chartPath;
@property (nonatomic, strong) NSMutableArray *pointPath;

//@property (nonatomic, strong) NSMutableArray *chartFillArray;

@property (nonatomic, strong) UIColor *fillColor;

@end

@implementation HDCurveChart

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor whiteColor];
    _chartLineArray = [NSMutableArray new];
    _chartPointArray = [NSMutableArray new];
    //    _chartFillArray = [NSMutableArray new];

    _showCoordinateAxis = YES;
    _axisColor = [UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1];
    _axisWidth = 1;

    _fillColor = [UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:0.3];

    _chartMargin = 15;

    _xValueMax = 60;
    _xValueMin = 0;
    _xStepNum = 60;
    _xPeriodFillNum = 2;

    _yValueMax = 25;
    _yValueMin = 0;
    _yStepNum = 25;
}

#pragma mark
#pragma mark Setter

- (void)setChartDatas:(NSArray *)chartDatas
{
    if (chartDatas != _chartDatas)
    {
        _chartDatas = chartDatas;
        [_chartLineArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [_chartPointArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        //        [_chartFillArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

        // add lines
        for (HDCurveChartData *chartData in _chartDatas)
        {

            // create Fill Layer
            //            CAShapeLayer *chartFillLayer = [CAShapeLayer layer];
            //            chartFillLayer.lineCap = kCALineCapButt;
            //            chartFillLayer.lineJoin = kCALineJoinMiter;
            //            chartFillLayer.fillColor = [[UIColor clearColor] CGColor];
            //            chartFillLayer.lineWidth = chartData.lineWidth;
            //            chartFillLayer.strokeEnd = 0.0;
            //            [self.layer addSublayer:chartFillLayer];
            //            [_chartFillArray addObject:chartFillLayer];

            CAShapeLayer *chartLineLayer = [CAShapeLayer layer];
            chartLineLayer.lineCap = kCALineCapButt;
            chartLineLayer.lineJoin = kCALineJoinMiter;
            chartLineLayer.fillColor = [[UIColor clearColor] CGColor];
            chartLineLayer.lineWidth = chartData.lineWidth;
            chartLineLayer.strokeEnd = 0.0;
            [self.layer addSublayer:chartLineLayer];
            [_chartLineArray addObject:chartLineLayer];

            // create point
            CAShapeLayer *pointLayer = [CAShapeLayer layer];
            pointLayer.strokeColor = [chartData.linColor CGColor];
            pointLayer.lineCap = kCALineCapRound;
            pointLayer.lineJoin = kCALineJoinBevel;
            pointLayer.fillColor = nil;
            pointLayer.lineWidth = chartData.lineWidth;
            [self.layer addSublayer:pointLayer];
            [_chartPointArray addObject:pointLayer];
        }
        [self setNeedsDisplay];
    }
}

#pragma mark
#pragma mark Renders

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (_showCoordinateAxis)
    {
        // config context
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        CGContextSetLineWidth(context, _axisWidth);
        CGContextSetStrokeColorWithColor(context, _axisColor.CGColor);

        // config offset
        _chartCavanWidth = CGRectGetWidth(self.bounds) - _chartMargin * 2;
        _chartCavanHeight = CGRectGetHeight(self.bounds) - _chartMargin * 2;

        CGFloat arrowWidth = 3;

        CGFloat topLeftX = _chartMargin;
        CGFloat topLeftY = _chartMargin - arrowWidth * 2;

        CGFloat bottomLeftX = topLeftX;
        CGFloat bottomLeftY = _chartMargin + _chartCavanHeight;

        CGFloat boottomRightX = _chartMargin + _chartCavanWidth + arrowWidth * 2;
        CGFloat boottomRightY = bottomLeftY;

        // draw coordinate axis
        CGContextMoveToPoint(context, topLeftX, topLeftY);
        CGContextAddLineToPoint(context, bottomLeftX, bottomLeftY);
        CGContextAddLineToPoint(context, boottomRightX, boottomRightY);
        CGContextStrokePath(context);

        // draw y axis arrow
        CGContextMoveToPoint(context, topLeftX - arrowWidth, topLeftY + arrowWidth);
        CGContextAddLineToPoint(context, topLeftX, topLeftY);
        CGContextAddLineToPoint(context, topLeftX + arrowWidth, topLeftY + arrowWidth);
        CGContextStrokePath(context);

        // draw x axis arrow
        CGContextMoveToPoint(context, boottomRightX - arrowWidth, boottomRightY - arrowWidth);
        CGContextAddLineToPoint(context, boottomRightX, boottomRightY);
        CGContextAddLineToPoint(context, boottomRightX - arrowWidth, boottomRightY + arrowWidth);
        CGContextStrokePath(context);

        // draw x axis separator
        CGFloat xStepHeight = 2;
        CGFloat xStepValue = (_xValueMax - _xValueMin) / _xStepNum;
        CGFloat xStepWidth = (CGRectGetWidth(self.bounds) - 2 * _chartMargin) / _xStepNum;
        for (NSUInteger i = 0; i < _xStepNum + 1; i++)
        {
            CGFloat postionX = [self postionXForValue:xStepValue * i + _xValueMin
                                             minValue:_xValueMin
                                             maxValue:_xValueMax];
            xStepHeight = 2;
            BOOL showXGraduation = NO;
            BOOL showXLabel = NO;
            if (_xShowGraduation)
            {
                showXGraduation = _xShowGraduation(i);
            }
            if (_xShowLabel)
            {
                showXLabel = _xShowLabel(i);
            }
            if (showXLabel)
            {
                NSString *xLabelString = @"";
                if (_getXLabel)
                {
                    xLabelString = _getXLabel(i);
                }
                xStepHeight = 4;
                CGSize labelSize = [xLabelString
                    sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:7]}];
                [self drawTextInContext:context
                                   text:xLabelString
                                 inRect:CGRectMake(postionX - 5, bottomLeftY + 5, labelSize.width,
                                                   labelSize.height)
                                   font:[UIFont systemFontOfSize:7]];
            }
            if (showXGraduation)
            {
                CGContextMoveToPoint(context, postionX, bottomLeftY);
                CGContextAddLineToPoint(context, postionX, bottomLeftY - xStepHeight);
                CGContextStrokePath(context);
            }
            // fill background
            if (i % _xPeriodFillNum == 0)
            {
                CGContextSetFillColorWithColor(context, _fillColor.CGColor);
                CGContextFillRect(context,
                                  CGRectMake(postionX, topLeftY, xStepWidth * _xPeriodFillNum / 2,
                                             bottomLeftY - topLeftY));
                CGContextStrokePath(context);
            }

            CGContextSetStrokeColorWithColor(context, _axisColor.CGColor);
        }
        // draw y axis separator
        CGFloat yStepValue = (_yValueMax - _yValueMin) / _yStepNum;
        for (NSUInteger i = 0; i < _yStepNum + 1; i++)
        {
            CGFloat postionY = [self postionYForValue:yStepValue * i + _yValueMin
                                             minValue:_yValueMin
                                             maxValue:_yValueMax];
            xStepHeight = 2;

            BOOL showYGraduation = NO;
            BOOL showYLabel = NO;
            if (_yShowGraduation)
            {
                showYGraduation = _yShowGraduation(i);
            }
            if (_yShowLabel)
            {
                showYLabel = _yShowLabel(i);
            }
            if (showYLabel)
            {
                NSString *yLabelString = @"";
                if (_getYLabel)
                {
                    yLabelString = _getYLabel(i);
                }
                xStepHeight = 4;
                [self drawTextInContext:context
                                   text:yLabelString
                                 inRect:CGRectMake(bottomLeftX - 16, postionY - 5, 15, 10)
                                   font:[UIFont systemFontOfSize:7]];
            }
            if (showYGraduation)
            {
                CGContextMoveToPoint(context, bottomLeftX, postionY);
                CGContextAddLineToPoint(context, bottomLeftX + xStepHeight, postionY);
                CGContextStrokePath(context);
            }
        }
    }

    [self strokeChart];
}

- (void)strokeChart
{
    _chartPath = [NSMutableArray new];
    _pointPath = [NSMutableArray new];

    for (NSUInteger lineIndex = 0; lineIndex < _chartDatas.count; lineIndex++)
    {
        HDCurveChartData *chartData = _chartDatas[lineIndex];
        CAShapeLayer *chartLineLayer = _chartLineArray[lineIndex];
        //        CAShapeLayer *pointLayer = _chartPointArray[lineIndex];
        //        CAShapeLayer *chartFillLayer = _chartFillArray[lineIndex];

        UIGraphicsBeginImageContext(self.bounds.size);

        UIBezierPath *progressLine = [UIBezierPath bezierPath];
        [progressLine setLineWidth:chartData.lineWidth];
        [progressLine setLineCapStyle:kCGLineCapRound];
        [progressLine setLineJoinStyle:kCGLineJoinRound];

        UIBezierPath *pointPath = [UIBezierPath bezierPath];
        [pointPath setLineWidth:chartData.lineWidth];

        [_chartPath addObject:progressLine];
        [_pointPath addObject:pointPath];
        CGFloat x;
        CGFloat y;
        NSInteger pointCount = chartData.points.count;
        for (NSUInteger i = 0; i < pointCount; i++)
        {
            HDCurveChartDataItem *item = chartData.points[i];
            x = [self postionXForValue:item.x minValue:_xValueMin maxValue:_xValueMax];
            y = [self postionYForValue:item.y minValue:_yValueMin maxValue:_yValueMax];

            if (i != 0)
            {
                if (chartData.chartStyle == HDChartStyleLine)
                {
                    [progressLine addLineToPoint:CGPointMake(x, y)];
                }
                else if (chartData.chartStyle == HDChartStyleCurve)
                {
                    HDCurveChartDataItem *preItem;
                    HDCurveChartDataItem *centerItem;
                    HDCurveChartDataItem *nextItem;

                    CGPoint preItemPoint = CGPointZero;
                    CGPoint centerItemPoint = CGPointZero;
                    CGPoint nextItemPoint = CGPointZero;

                    //两个控制点
                    if ((i - 1) > 0 && ((i + 1) <= (pointCount - 1)))
                    {
                        HDCurveChartDataItem *ppreItem = chartData.points[i - 2];
                        preItem = chartData.points[i - 1];
                        centerItem = chartData.points[i];
                        nextItem = chartData.points[i + 1];

                        CGPoint ppreItemPoint;
                        ppreItemPoint.x = [self postionXForValue:ppreItem.x
                                                        minValue:_xValueMin
                                                        maxValue:_xValueMax];
                        ppreItemPoint.y = [self postionYForValue:ppreItem.y
                                                        minValue:_yValueMin
                                                        maxValue:_yValueMax];

                        preItemPoint.x = [self postionXForValue:preItem.x
                                                       minValue:_xValueMin
                                                       maxValue:_xValueMax];
                        preItemPoint.y = [self postionYForValue:preItem.y
                                                       minValue:_yValueMin
                                                       maxValue:_yValueMax];
                        centerItemPoint.x = [self postionXForValue:centerItem.x
                                                          minValue:_xValueMin
                                                          maxValue:_xValueMax];
                        centerItemPoint.y = [self postionYForValue:centerItem.y
                                                          minValue:_yValueMin
                                                          maxValue:_yValueMax];
                        nextItemPoint.x = [self postionXForValue:nextItem.x
                                                        minValue:_xValueMin
                                                        maxValue:_xValueMax];
                        nextItemPoint.y = [self postionYForValue:nextItem.y
                                                        minValue:_yValueMin
                                                        maxValue:_yValueMax];

                        CGPoint ffirstCenter =
                            CGPointMake((preItemPoint.x - ppreItemPoint.x) / 2 + ppreItemPoint.x,
                                        (preItemPoint.y - ppreItemPoint.y) / 2 + ppreItemPoint.y);
                        CGPoint firstCenter =
                            CGPointMake((centerItemPoint.x - preItemPoint.x) / 2 + preItemPoint.x,
                                        (centerItemPoint.y - preItemPoint.y) / 2 + preItemPoint.y);
                        CGPoint secondCenter = CGPointMake(
                            (nextItemPoint.x - centerItemPoint.x) / 2 + centerItemPoint.x,
                            (nextItemPoint.y - centerItemPoint.y) / 2 + centerItemPoint.y);

                        CGPoint centerPoint1 =
                            CGPointMake((firstCenter.x - ffirstCenter.x) / 2 + ffirstCenter.x,
                                        (firstCenter.y - ffirstCenter.y) / 2 + ffirstCenter.y);
                        CGPoint centerPoint2 =
                            CGPointMake((secondCenter.x - firstCenter.x) / 2 + firstCenter.x,
                                        (secondCenter.y - firstCenter.y) / 2 + firstCenter.y);

                        CGPoint firstControlPoint =
                            CGPointMake(preItemPoint.x / centerPoint1.x * firstCenter.x,
                                        preItemPoint.y / centerPoint1.y * firstCenter.y);
                        CGPoint secondControlPoint =
                            CGPointMake(centerItemPoint.x / centerPoint2.x * firstCenter.x,
                                        centerItemPoint.y / centerPoint2.y * firstCenter.y);

                        [progressLine addCurveToPoint:CGPointMake(x, y)
                                        controlPoint1:firstControlPoint
                                        controlPoint2:secondControlPoint];
                    }
                    else
                    {
                        if ((i - 1) == 0 && pointCount > 2)
                        {
                            preItem = chartData.points[i - 1];
                            centerItem = chartData.points[i];
                            nextItem = chartData.points[i + 1];

                            preItemPoint.x = [self postionXForValue:preItem.x
                                                           minValue:_xValueMin
                                                           maxValue:_xValueMax];
                            preItemPoint.y = [self postionYForValue:preItem.y
                                                           minValue:_yValueMin
                                                           maxValue:_yValueMax];
                            centerItemPoint.x = [self postionXForValue:centerItem.x
                                                              minValue:_xValueMin
                                                              maxValue:_xValueMax];
                            centerItemPoint.y = [self postionYForValue:centerItem.y
                                                              minValue:_yValueMin
                                                              maxValue:_yValueMax];
                            nextItemPoint.x = [self postionXForValue:nextItem.x
                                                            minValue:_xValueMin
                                                            maxValue:_xValueMax];
                            nextItemPoint.y = [self postionYForValue:nextItem.y
                                                            minValue:_yValueMin
                                                            maxValue:_yValueMax];

                            CGPoint firstCenter = CGPointMake(
                                (centerItemPoint.x - preItemPoint.x) / 2 + preItemPoint.x,
                                (centerItemPoint.y - preItemPoint.y) / 2 + preItemPoint.y);
                            CGPoint secondCenter = CGPointMake(
                                (nextItemPoint.x - centerItemPoint.x) / 2 + centerItemPoint.x,
                                (nextItemPoint.y - centerItemPoint.y) / 2 + centerItemPoint.y);
                            CGPoint centerPoint =
                                CGPointMake((secondCenter.x - firstCenter.x) / 2 + firstCenter.x,
                                            (secondCenter.y - firstCenter.y) / 2 + firstCenter.y);

                            CGPoint controlPoint =
                                CGPointMake(centerItemPoint.x / centerPoint.x * firstCenter.x,
                                            centerItemPoint.y / centerPoint.y * firstCenter.y);
                            [progressLine addQuadCurveToPoint:CGPointMake(x, y)
                                                 controlPoint:controlPoint];
                        }
                        else if ((i + 1) == pointCount && pointCount > 2)
                        {
                            preItem = chartData.points[i - 2];
                            centerItem = chartData.points[i - 1];
                            nextItem = chartData.points[i];

                            preItemPoint.x = [self postionXForValue:preItem.x
                                                           minValue:_xValueMin
                                                           maxValue:_xValueMax];
                            preItemPoint.y = [self postionYForValue:preItem.y
                                                           minValue:_yValueMin
                                                           maxValue:_yValueMax];
                            centerItemPoint.x = [self postionXForValue:centerItem.x
                                                              minValue:_xValueMin
                                                              maxValue:_xValueMax];
                            centerItemPoint.y = [self postionYForValue:centerItem.y
                                                              minValue:_yValueMin
                                                              maxValue:_yValueMax];
                            nextItemPoint.x = [self postionXForValue:nextItem.x
                                                            minValue:_xValueMin
                                                            maxValue:_xValueMax];
                            nextItemPoint.y = [self postionYForValue:nextItem.y
                                                            minValue:_yValueMin
                                                            maxValue:_yValueMax];

                            CGPoint firstCenter = CGPointMake(
                                (centerItemPoint.x - preItemPoint.x) / 2 + preItemPoint.x,
                                (centerItemPoint.y - preItemPoint.y) / 2 + preItemPoint.y);
                            CGPoint secondCenter = CGPointMake(
                                (nextItemPoint.x - centerItemPoint.x) / 2 + centerItemPoint.x,
                                (nextItemPoint.y - centerItemPoint.y) / 2 + centerItemPoint.y);
                            CGPoint centerPoint =
                                CGPointMake((secondCenter.x - firstCenter.x) / 2 + firstCenter.x,
                                            (secondCenter.y - firstCenter.y) / 2 + firstCenter.y);

                            CGPoint controlPoint =
                                CGPointMake(centerItemPoint.x / centerPoint.x * secondCenter.x,
                                            centerItemPoint.y / centerPoint.y * secondCenter.y);
                            [progressLine addQuadCurveToPoint:CGPointMake(x, y)
                                                 controlPoint:controlPoint];
                        }
                        else
                        {
                            [progressLine addLineToPoint:CGPointMake(x, y)];
                        }
                    }
                }
            }
            [progressLine moveToPoint:CGPointMake(x, y)];
        }

        if (chartData.linColor)
        {
            chartLineLayer.strokeColor = chartData.linColor.CGColor;
        }
        [progressLine stroke];
        chartLineLayer.path = progressLine.CGPath;

        // fill layer
        //        HDCurveChartDataItem *startItem = chartData.points[0];
        //        HDCurveChartDataItem *lastItem = chartData.points[pointCount - 1];
        //        CGFloat startX =
        //            [self postionXForValue:startItem.x minValue:_xValueMin maxValue:_xValueMax];
        //        CGFloat startY =
        //            [self postionYForValue:startItem.y minValue:_yValueMin maxValue:_yValueMax];
        //        CGFloat lastX = [self postionXForValue:lastItem.x minValue:_xValueMin
        //        maxValue:_xValueMax];
        //
        //        UIBezierPath *fillPath = [UIBezierPath bezierPath];
        //        for (NSUInteger i = 0; i < pointCount; i++)
        //        {
        //            HDCurveChartDataItem *item = chartData.points[i];
        //            x = [self postionXForValue:item.x minValue:_xValueMin maxValue:_xValueMax];
        //            y = [self postionYForValue:item.y minValue:_yValueMin maxValue:_yValueMax];
        //            if (i == 0)
        //            {
        //                [fillPath moveToPoint:CGPointMake(x, y)];
        //            }
        //            else
        //            {
        //                [fillPath addLineToPoint:CGPointMake(x, y)];
        //            }
        //        }
        //
        //        [fillPath
        //            addLineToPoint:CGPointMake(
        //                               lastX,
        //                               [self postionYForValue:0 minValue:_yValueMin
        //                               maxValue:_yValueMax])];
        //        [fillPath
        //            addLineToPoint:CGPointMake(
        //                               startX,
        //                               [self postionYForValue:0 minValue:_yValueMin
        //                               maxValue:_yValueMax])];
        //        [fillPath addLineToPoint:CGPointMake(startX, startY)];
        //
        //        [fillPath addLineToPoint:CGPointMake(startX, startY)];
        //        [fillPath stroke];

        //        chartFillLayer.frame = self.bounds;
        //        chartFillLayer.path = fillPath.CGPath;
        //        chartFillLayer.lineWidth = 0;
        //        chartFillLayer.lineJoin = kCALineJoinRound;
        //        if (chartData.linColor)
        //        {
        //            chartFillLayer.fillColor = chartData.linColor.CGColor;
        //        }

        [CATransaction begin];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 1.0;
        pathAnimation.timingFunction =
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;

        [chartLineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

        //        [chartFillLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        //        chartFillLayer.strokeEnd = 1.0;

        [CATransaction commit];
        chartLineLayer.strokeEnd = 1.0;
        UIGraphicsEndImageContext();
    }
}
#pragma mark
#pragma mark Utils

- (CGFloat)postionXForValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue
{
    value = MAX(MIN(value, maxValue), minValue);
    CGFloat percentage = (value - minValue) / (maxValue - minValue);
    return (CGRectGetWidth(self.bounds) - 2 * _chartMargin) * percentage + _chartMargin;
}

- (CGFloat)postionYForValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue
{
    value = MAX(MIN(value, maxValue), minValue);
    CGFloat percentage = (value - minValue) / (maxValue - minValue);
    return (CGRectGetHeight(self.bounds) -
            ((CGRectGetHeight(self.bounds) - 2 * _chartMargin) * percentage + _chartMargin));
}

#define IOS7_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

- (void)drawTextInContext:(CGContextRef)ctx
                     text:(NSString *)text
                   inRect:(CGRect)rect
                     font:(UIFont *)font
{
    if (IOS7_OR_LATER)
    {
        NSMutableParagraphStyle *priceParagraphStyle =
            [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        priceParagraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        priceParagraphStyle.alignment = NSTextAlignmentCenter;

        [text drawInRect:rect
            withAttributes:@{
                NSParagraphStyleAttributeName : priceParagraphStyle,
                NSFontAttributeName : font
            }];
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [text drawInRect:rect
                 withFont:font
            lineBreakMode:NSLineBreakByTruncatingTail
                alignment:NSTextAlignmentCenter];
#pragma clang diagnostic pop
    }
}

@end

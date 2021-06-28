//
//  HeartLive.m
//  HeartRateCurve
//
//  Created by IOS－001 on 14-4-23.
//  Copyright (c) 2014年 N/A. All rights reserved.
//

#import "HeartLive.h"
#import "HeartLiveGrid.h"
#import "HeartLiveCure.h"
#import "HeartLivePointContainer.h"

@interface HeartLive ()

@property (nonatomic , assign) NSInteger currentPointsCount;
@property (strong, nonatomic) HeartLiveGrid *gridView;
@property (strong, nonatomic) HeartLiveCure *cureView;
@property (strong, nonatomic) HeartLivePointContainer *pointContainer;

/// 绘制页面
- (void)fireDrawingWithPoints:(CGPoint *)points pointsCount:(NSInteger)count;

/// 得出最新的点
- (CGPoint)bubbleRefreshPoint:(NSArray *)dataSource;

/// 得出最新的点
- (CGPoint)bubbleTranslationPoint:(NSArray *)dataSource;

@end

@implementation HeartLive

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _gridView = [HeartLiveGrid new];
    _cureView = [HeartLiveCure new];
    [self addSubview:_gridView];
    [self addSubview:_cureView];
    _pointContainer = [HeartLivePointContainer sharedContainer];
}

- (void)drawRect:(CGRect)rect
{
    _gridView.frame = self.bounds;
    _cureView.frame = self.bounds;
}

- (void)refreshWithDataSoure:(NSArray *)dataSource {
    if (dataSource.count == 0) {
        return;
    }
    [_pointContainer addPointAsRefreshChangeform:[self bubbleRefreshPoint:dataSource]];
    [self fireDrawingWithPoints:_pointContainer.refreshPointContainer
                    pointsCount:_pointContainer.numberOfRefreshElements];
}

- (void)fireDrawingWithPoints:(CGPoint *)points pointsCount:(NSInteger)count
{
    _cureView.currentPointsCount = count;
    _cureView.points = points;
}

- (CGPoint)bubbleRefreshPoint:(NSArray *)dataSource {
    static NSInteger dataSourceCounterIndex = -1;
    dataSourceCounterIndex ++;
    dataSourceCounterIndex %= [dataSource count];
    
    NSInteger pixelPerPoint = 1;
    static NSInteger xCoordinateInMoniter = 0;
    
    CGPoint targetPointToAdd = (CGPoint){xCoordinateInMoniter,[dataSource[dataSourceCounterIndex] integerValue] * 0.5 + 120};
    xCoordinateInMoniter += pixelPerPoint;
    xCoordinateInMoniter %= (int)(CGRectGetWidth(self.frame));
    return targetPointToAdd;
}

- (CGPoint)bubbleTranslationPoint:(NSArray *)dataSource {
    static NSInteger dataSourceCounterIndex = -1;
    dataSourceCounterIndex ++;
    dataSourceCounterIndex %= [dataSource count];
    
    NSInteger pixelPerPoint = 1;
    static NSInteger xCoordinateInMoniter = 0;
    
    CGPoint targetPointToAdd = (CGPoint){xCoordinateInMoniter,[dataSource[dataSourceCounterIndex] integerValue] * 0.5 + 120};
    xCoordinateInMoniter += pixelPerPoint;
    xCoordinateInMoniter %= (int)(CGRectGetWidth(self.frame));
    
    return targetPointToAdd;
}
@end

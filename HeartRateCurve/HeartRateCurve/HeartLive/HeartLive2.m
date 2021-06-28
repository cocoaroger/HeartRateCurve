//
//  HeartLive2.m
//  HeartRateCurve
//
//  Created by roger wu on 2021/6/26.
//  Copyright © 2021 N/A. All rights reserved.
//

#import "HeartLive2.h"
#import "HeartLiveGrid.h"
#import "HeartLiveCure.h"

static const NSInteger kMaxContainerCapacity = 10000;

@interface HeartLive2 ()

@property (nonatomic , assign) CGPoint *points;
@property (nonatomic , assign) NSInteger currentPointsCount;
@property (strong, nonatomic) HeartLiveGrid *gridView;
@property (strong, nonatomic) HeartLiveCure *cureView;

/// 绘制页面
- (void)fireDrawingWithPoints:(CGPoint *)points pointsCount:(NSInteger)count;

@end

@implementation HeartLive2

- (void)dealloc
{
    free(self.points);
    self.points = NULL;
}

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
    _points = malloc(sizeof(CGPoint) * kMaxContainerCapacity);
    memset(_points, 0, sizeof(CGPoint) * kMaxContainerCapacity);
}

- (void)drawRect:(CGRect)rect
{
    _gridView.frame = self.bounds;
    _cureView.frame = self.bounds;
}

- (void)refreshWithDataSoure:(NSArray<NSNumber *> *)dataSource {
    if (dataSource.count == 0) {
        return;
    }
    CGRect oldFrame = self.frame;
    oldFrame.size.width = dataSource.count;
    self.frame = oldFrame;
    for (NSInteger index = 0; index < dataSource.count; index++) {
        NSNumber *value = dataSource[index];
        NSInteger xCoordinateInMoniter = index;
        CGPoint targetPoint = (CGPoint){xCoordinateInMoniter, [value integerValue] * 0.5 + 120};
        self.points[index] = targetPoint;
    }
    
    [self fireDrawingWithPoints:self.points
                    pointsCount:dataSource.count];
    
}

- (void)fireDrawingWithPoints:(CGPoint *)points pointsCount:(NSInteger)count
{
    _cureView.currentPointsCount = count;
    _cureView.points = points;
}

@end

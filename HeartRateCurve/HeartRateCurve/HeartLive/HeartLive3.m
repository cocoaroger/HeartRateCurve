//
//  HeartLive3.m
//  HeartRateCurve
//
//  Created by roger wu on 2021/6/26.
//  Copyright © 2021 N/A. All rights reserved.
//

#import "HeartLive3.h"
#import "HeartLiveGrid3.h"
#import "HeartLiveCure.h"
static const NSInteger kMaxContainerCapacity = 10000;

@interface HeartLive3 ()

@property (nonatomic , assign) CGPoint *points;
@property (nonatomic , assign) NSInteger currentPointsCount;
@property (strong, nonatomic) HeartLiveGrid3 *gridView;
@property (strong, nonatomic) HeartLiveCure *cureView;

/// 绘制页面
- (void)fireDrawingWithPoints:(CGPoint *)points pointsCount:(NSInteger)count;

@end

@implementation HeartLive3

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
    _gridView = [HeartLiveGrid3 new];
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
    CGRect viewFrame = self.frame;
    CGFloat oneHeight = 80;
    NSInteger viewWidth = viewFrame.size.width;
    
    for (NSInteger index = 0; index < dataSource.count; index++) {
        NSInteger value = [dataSource[index] integerValue];
        
        NSInteger xCoordinateInMoniter = index % viewWidth;
        NSInteger row = index/viewWidth;
        
        CGFloat yCoordinateInMoniter = value / 8 + oneHeight/2 + row * oneHeight;
        
        CGPoint targetPoint = (CGPoint){xCoordinateInMoniter, yCoordinateInMoniter};
        self.points[index] = targetPoint;
    }
    viewFrame.size.height = dataSource.count/viewWidth * oneHeight;
    self.frame = viewFrame;
    
    [self fireDrawingWithPoints:self.points
                    pointsCount:dataSource.count];
    
}

- (void)fireDrawingWithPoints:(CGPoint *)points pointsCount:(NSInteger)count
{
    _cureView.currentPointsCount = count;
    _cureView.points = points;
}

@end

//
//  HeartLivePointContainer.m
//  HeartRateCurve
//
//  Created by roger wu on 2021/6/26.
//  Copyright © 2021 N/A. All rights reserved.
//

#import "HeartLivePointContainer.h"
static const NSInteger kMaxContainerCapacity = 300;

@interface HeartLivePointContainer ()
@property (nonatomic , assign) NSInteger numberOfRefreshElements;
@property (nonatomic , assign) NSInteger numberOfTranslationElements;

@property (nonatomic , assign) CGPoint *refreshPointContainer;
@property (nonatomic , assign) CGPoint *translationPointContainer;

@end

@implementation HeartLivePointContainer

- (void)dealloc
{
    free(self.refreshPointContainer);
    free(self.translationPointContainer);
    self.refreshPointContainer = self.translationPointContainer = NULL;
}

+ (HeartLivePointContainer *)sharedContainer
{
    static HeartLivePointContainer *container_ptr = NULL;
    container_ptr = [[self alloc] init];
    container_ptr.refreshPointContainer = malloc(sizeof(CGPoint) * kMaxContainerCapacity);
    memset(container_ptr.refreshPointContainer, 0, sizeof(CGPoint) * kMaxContainerCapacity);
    
    container_ptr.translationPointContainer = malloc(sizeof(CGPoint) * kMaxContainerCapacity);
    memset(container_ptr.translationPointContainer, 0, sizeof(CGPoint) * kMaxContainerCapacity);
    return container_ptr;
}

- (void)addPointAsRefreshChangeform:(CGPoint)point
{
    static NSInteger currentPointsCount = 0;
    if (currentPointsCount < kMaxContainerCapacity) {
        self.numberOfRefreshElements = currentPointsCount + 1;
        self.refreshPointContainer[currentPointsCount] = point;
        currentPointsCount ++;
    } else {
        NSInteger workIndex = 0;
        while (workIndex != kMaxContainerCapacity - 1) {
            self.refreshPointContainer[workIndex] = self.refreshPointContainer[workIndex + 1];
            workIndex ++;
        }
        self.refreshPointContainer[kMaxContainerCapacity - 1] = point;
        self.numberOfRefreshElements = kMaxContainerCapacity;
    }
}

- (void)addPointAsTranslationChangeform:(CGPoint)point
{
    static NSInteger currentPointsCount = 0;
    if (currentPointsCount < kMaxContainerCapacity) {
        self.numberOfTranslationElements = currentPointsCount + 1;
        self.translationPointContainer[currentPointsCount] = point;
        currentPointsCount ++;
    } else {
        NSInteger workIndex = kMaxContainerCapacity - 1;
        while (workIndex != 0) {
            self.translationPointContainer[workIndex].y = self.translationPointContainer[workIndex - 1].y;
            workIndex --;
        }
        self.translationPointContainer[0].x = 0;
        self.translationPointContainer[0].y = point.y;
        self.numberOfTranslationElements = kMaxContainerCapacity;
    }
}

@end

//
//  HeartLivePointContainer2.m
//  HeartRateCurve
//
//  Created by roger wu on 2021/6/26.
//  Copyright © 2021 N/A. All rights reserved.
//

#import "HeartLivePointContainer2.h"

static const NSInteger kMaxContainerCapacity = 10000;

@interface HeartLivePointContainer2 ()

@property (nonatomic , assign) NSInteger numberOfTranslationElements;
@property (nonatomic , assign) CGPoint *translationPointContainer;

@end

@implementation HeartLivePointContainer2

- (void)dealloc
{
    free(self.translationPointContainer);
    self.translationPointContainer = NULL;
}

+ (HeartLivePointContainer2 *)sharedContainer
{
    static HeartLivePointContainer2 *container_ptr = NULL;
    container_ptr = [[self alloc] init];
    container_ptr.translationPointContainer = malloc(sizeof(CGPoint) * kMaxContainerCapacity);
    memset(container_ptr.translationPointContainer, 0, sizeof(CGPoint) * kMaxContainerCapacity);
    return container_ptr;
}

- (void)addPointAsTranslationChangeform:(NSArray *)points {
    self.numberOfTranslationElements = points.count;
    for (point in points) {
        self.translationPointContainer[currentPointsCount] = point;
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

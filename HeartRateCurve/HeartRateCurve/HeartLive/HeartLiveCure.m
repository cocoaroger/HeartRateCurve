//
//  HeartLiveCure.m
//  HeartRate
//
//  Created by roger wu on 2021/6/26.
//

#import "HeartLiveCure.h"

@implementation HeartLiveCure

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clearsContextBeforeDrawing = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setPoints:(CGPoint *)points {
    _points = points;
    [self setNeedsDisplay];
}

- (void)drawCurve {
    if (self.currentPointsCount == 0) {
        return;
    }
    CGFloat curveLineWidth = 0.8;
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext, curveLineWidth);
    UIColor *lineColor = [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.00];
    
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), lineColor.CGColor);
    
    CGContextMoveToPoint(currentContext, self.points[0].x, self.points[0].y);
    for (int i = 1; i != self.currentPointsCount; ++ i) {
        if (self.points[i - 1].x < self.points[i].x) {
            CGContextAddLineToPoint(currentContext, self.points[i].x, self.points[i].y);
        } else {
            CGContextMoveToPoint(currentContext, self.points[i].x, self.points[i].y);
        }
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
}

- (void)drawRect:(CGRect)rect {
    [self drawCurve];
}

@end

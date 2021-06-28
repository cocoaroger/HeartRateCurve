//
//  HeartLiveGrid.m
//  HeartRate
//
//  Created by roger wu on 2021/6/26.
//

#import "HeartLiveGrid.h"

@implementation HeartLiveGrid

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
}

- (void)drawGrid {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat full_height = self.frame.size.height;
    CGFloat full_width = self.frame.size.width;
    CGFloat cell_square_width = 30;
    
    CGContextSetLineWidth(context, 0.2);
    UIColor *lineColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    
    int pos_x = 1;
    while (pos_x < full_width) {
        CGContextMoveToPoint(context, pos_x, 1);
        CGContextAddLineToPoint(context, pos_x, full_height);
        pos_x += cell_square_width;
        CGContextStrokePath(context);
    }
    
    CGFloat pos_y = 1;
    while (pos_y <= full_height) {
        CGContextSetLineWidth(context, 0.2);
        CGContextMoveToPoint(context, 1, pos_y);
        CGContextAddLineToPoint(context, full_width, pos_y);
        pos_y += cell_square_width;
        CGContextStrokePath(context);
    }
    CGContextSetLineWidth(context, 0.1);
    
    cell_square_width = cell_square_width / 5;
    pos_x = 1 + cell_square_width;
    while (pos_x < full_width) {
        CGContextMoveToPoint(context, pos_x, 1);
        CGContextAddLineToPoint(context, pos_x, full_height);
        pos_x += cell_square_width;
        CGContextStrokePath(context);
    }
    
    pos_y = 1 + cell_square_width;
    while (pos_y <= full_height) {
        CGContextMoveToPoint(context, 1, pos_y);
        CGContextAddLineToPoint(context, full_width, pos_y);
        pos_y += cell_square_width;
        CGContextStrokePath(context);
    }
}

- (void)drawRect:(CGRect)rect {
    [self drawGrid];
}

@end

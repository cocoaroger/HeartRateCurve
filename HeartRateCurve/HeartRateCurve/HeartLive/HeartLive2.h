//
//  HeartLive2.h
//  HeartRateCurve
//
//  Created by roger wu on 2021/6/26.
//  Copyright © 2021 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeartLive2 : UIView

/// 刷新页面
- (void)refreshWithDataSoure:(NSArray<NSNumber*> *)dataSource;

@end

NS_ASSUME_NONNULL_END

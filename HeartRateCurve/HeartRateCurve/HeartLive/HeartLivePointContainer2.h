//
//  HeartLivePointContainer2.h
//  HeartRateCurve
//
//  Created by roger wu on 2021/6/26.
//  Copyright © 2021 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeartLivePointContainer2 : NSObject

@property (nonatomic , readonly) NSInteger numberOfTranslationElements;
@property (nonatomic , readonly) CGPoint *translationPointContainer;

+ (HeartLivePointContainer2 *)sharedContainer;

//平移变换
- (void)addPointAsTranslationChangeform:(NSArray *)points;

@end

NS_ASSUME_NONNULL_END

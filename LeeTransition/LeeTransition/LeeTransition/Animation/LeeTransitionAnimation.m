//
//  LeeTransitionAnimation.m
//  LeeTransition
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LeeTransitionAnimation.h"

@interface LeeTransitionAnimation ()

/**
 动画时间
 */
@property (nonatomic,assign) NSTimeInterval duration;

@end

@implementation LeeTransitionAnimation

- (id)initWithDuration:(NSTimeInterval)duration
{
    self = [super init];
    if (self) {
        _duration = duration;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.animationBlock) {
        self.animationBlock(transitionContext);
    }
}
@end

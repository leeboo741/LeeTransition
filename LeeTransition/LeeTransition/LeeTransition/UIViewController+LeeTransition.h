//
//  UIViewController+LeeTransition.h
//  LeeTransition
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager/LeeTransitionManager.h"
#import "Interactive/LeeInteractiveTransition.h"

extern NSString *const kAnimationKey;
extern NSString *const kToAnimationKey;

@interface UIViewController (LeeTransition)
/**
 push动画
 
 @param viewController 被push viewController
 @param transitionManager 控制类
 */
- (void)lee_pushViewControler:(UIViewController *)viewController withAnimation:(LeeTransitionManager*)transitionManager;


/**
 present动画
 
 @param viewController 被present viewController
 @param transitionManager 控制类
 */
- (void)lee_presentViewControler:(UIViewController *)viewController withAnimation:(LeeTransitionManager*)transitionManager;


/**
 注册入场手势
 
 @param direction 方向
 @param blcok 手势转场触发的点击事件
 */
- (void)lee_registerToInteractiveTransitionWithDirection:(LeeEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok;

/**
 注册返回手势
 
 @param direction 侧滑方向
 @param blcok 手势转场触发的点击事件
 */
- (void)lee_registerBackInteractiveTransitionWithDirection:(LeeEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok;
@end

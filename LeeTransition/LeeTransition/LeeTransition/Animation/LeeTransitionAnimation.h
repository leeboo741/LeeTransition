//
//  LeeTransitionAnimation.h
//  LeeTransition
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019年 mac. All rights reserved.
//

/*++++++++++++++++++++++++++*/
/* +++++ 转场动画控制器 +++++ */
/*++++++++++++++++++++++++++*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 LeeTransitionAnimation 块
 
 @param contextTransition 将满足UIViewControllerContextTransitioning协议的对象传到管理内 在管理类对动画统一实现
 */
typedef void(^LeeTransitionAnimationBlock)(id <UIViewControllerContextTransitioning> contextTransition);

@interface LeeTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,copy) LeeTransitionAnimationBlock animationBlock;

/**
 初始化方法
 
 @param duration 转场时间
 @return 返回
 */
- (id)initWithDuration:(NSTimeInterval)duration;

@end

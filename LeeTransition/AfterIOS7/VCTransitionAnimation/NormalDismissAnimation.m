//
//  NormalDismissAnimation.m
//  LeeTransition
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "NormalDismissAnimation.h"

@implementation NormalDismissAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 1. Get controllers from transition context
    // 获取转场上下文中的viewController
    // UITransitionContextToViewControllerKey 转场目标VC
    // UITransitionContextFromViewControllerKey 转场出发VC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for fromVC
    // 设置转场目标VC初始位置
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    // 3. Add target view to the container, and move it to back.
    // 将转场目标VC添加至转场容器
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    // 4. Do animate now
    // 执行动画
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end

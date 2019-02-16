//
//  LeeTransitionManager.m
//  LeeTransition
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019年 mac. All rights reserved.
//

/*++++++++++++++++++++++++++*/
/* +++++ 转场动画控制器 +++++ */
/*++++++++++++++++++++++++++*/

#import "LeeTransitionManager.h"
#import "../Animation/LeeTransitionAnimation.h"
#import "../Interactive/LeeInteractiveTransition.h"

@interface LeeTransitionManager ()


/**
 入场动画
 */
@property (nonatomic,strong) LeeTransitionAnimation * presentPushTransitionAnimation;

/**
 退场动画
 */
@property (nonatomic,strong) LeeTransitionAnimation * dismissPopTransitionAnimation;

/**
 入场手势
 */
@property (nonatomic,strong) LeeInteractiveTransition * presentPushInteractiveTransition;

/**
 退场手势
 */
@property (nonatomic,strong) LeeInteractiveTransition * dismissPopInteractiveTransition;

/**
 转场类型 push or pop
 */
@property (nonatomic,assign) UINavigationControllerOperation operation;
@end

@implementation LeeTransitionManager

- (id)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
    }
    return self;
}

#pragma mark -
#pragma mark LeeTransitionManagerProtocol

/**
 设置 dismiss|pop 转场动画
 
 @param contextTransitioning 转场上下文转换管理器
 */
- (void)setDismissPopAnimation:(id<UIViewControllerContextTransitioning>)contextTransitioning{
    NSLog(@"1 ==> dismiss");
    // 给个默认实现
    //获取目标动画的VC
    UIViewController *toVc = [contextTransitioning viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [contextTransitioning viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [contextTransitioning containerView];
    
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    //截图
    UIView *fromView_snapView = [fromView snapshotViewAfterScreenUpdates:YES];
    
    
    CGRect left_frame = CGRectMake(0, 0, CGRectGetWidth(toView.frame) / 2.0, CGRectGetHeight(toView.frame));
    CGRect right_frame = CGRectMake(CGRectGetWidth(toView.frame) / 2.0, 0, CGRectGetWidth(toView.frame) / 2.0, CGRectGetHeight(toView.frame));
    UIView *to_left_snapView = [toView resizableSnapshotViewFromRect:left_frame
                                                  afterScreenUpdates:YES
                                                       withCapInsets:UIEdgeInsetsZero];
    
    UIView *to_right_snapView = [toView resizableSnapshotViewFromRect:right_frame
                                                   afterScreenUpdates:YES
                                                        withCapInsets:UIEdgeInsetsZero];
    
    fromView_snapView.layer.transform = CATransform3DIdentity;
    to_left_snapView.frame = CGRectOffset(left_frame, -left_frame.size.width, 0);
    to_right_snapView.frame = CGRectOffset(right_frame, right_frame.size.width, 0);
    
    //将截图添加到 containerView 上
    [containerView addSubview:fromView_snapView];
    [containerView addSubview:to_left_snapView];
    [containerView addSubview:to_right_snapView];
    
    fromView.hidden = YES;
    
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //右移
        to_left_snapView.frame = CGRectOffset(to_left_snapView.frame, to_left_snapView.frame.size.width, 0);
        //左移
        to_right_snapView.frame = CGRectOffset(to_right_snapView.frame, -to_right_snapView.frame.size.width, 0);
        
        fromView_snapView.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1);
        
    } completion:^(BOOL finished) {
        fromView.hidden = NO;
        [fromView removeFromSuperview];
        [to_left_snapView removeFromSuperview];
        [to_right_snapView removeFromSuperview];
        [fromView_snapView removeFromSuperview];
        
        if ([contextTransitioning transitionWasCancelled]) {
            [containerView addSubview:fromView];
        } else {
            [containerView addSubview:toView];
        }
        [contextTransitioning completeTransition:![contextTransitioning transitionWasCancelled]];
    }];
}

/**
 设置 present|push 转场动画
 
 @param contextTransitioning 转场上下文转换管理器
 */
- (void)setPresentPushAnimation:(id<UIViewControllerContextTransitioning>)contextTransitioning{
    NSLog(@"1 ==> present");
    // 给个默认实现
    //获取目标动画的VC
    UIViewController *toVc = [contextTransitioning viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [contextTransitioning viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [contextTransitioning containerView];
    
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    //截图
    UIView *toView_snapView = [toView snapshotViewAfterScreenUpdates:YES];
    
    CGRect left_frame = CGRectMake(0, 0, CGRectGetWidth(fromView.frame) / 2.0, CGRectGetHeight(fromView.frame));
    CGRect right_frame = CGRectMake(CGRectGetWidth(fromView.frame) / 2.0, 0, CGRectGetWidth(fromView.frame) / 2.0, CGRectGetHeight(fromView.frame));
    UIView *from_left_snapView = [fromView resizableSnapshotViewFromRect:left_frame
                                                      afterScreenUpdates:NO
                                                           withCapInsets:UIEdgeInsetsZero];
    
    UIView *from_right_snapView = [fromView resizableSnapshotViewFromRect:right_frame
                                                       afterScreenUpdates:NO
                                                            withCapInsets:UIEdgeInsetsZero];
    
    toView_snapView.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1);
    from_left_snapView.frame = left_frame;
    from_right_snapView.frame = right_frame;
    
    //将截图添加到 containerView 上
    [containerView addSubview:toView_snapView];
    [containerView addSubview:from_left_snapView];
    [containerView addSubview:from_right_snapView];
    
    fromView.hidden = YES;
    
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //左移
        from_left_snapView.frame = CGRectOffset(from_left_snapView.frame, -from_left_snapView.frame.size.width, 0);
        //右移
        from_right_snapView.frame = CGRectOffset(from_right_snapView.frame, from_right_snapView.frame.size.width, 0);
        
        toView_snapView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished) {
        fromView.hidden = NO;
        
        [from_left_snapView removeFromSuperview];
        [from_right_snapView removeFromSuperview];
        [toView_snapView removeFromSuperview];
        
        if ([contextTransitioning transitionWasCancelled]) {
            [containerView addSubview:fromView];
        } else {
            [containerView addSubview:toView];
        }
        [contextTransitioning completeTransition:![contextTransitioning transitionWasCancelled]];
    }];
}

#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate

/**
 present 转场动画

 @param presented 转场开始VC
 @param presenting 转场结束VC
 @param source ？？？
 @return 转场动画对象
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentPushTransitionAnimation;
}

/**
 dismiss 转场动画

 @param dismissed 回退VC
 @return 转场动画对象
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissPopTransitionAnimation;
}

/**
 present 转场手势
 
 @param animator 转场动画对象
 @return 转场手势对象
 */
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.presentPushInteractiveTransition.isPanGestureInteration ? self.presentPushInteractiveTransition : nil;
}

/**
 dismiss 转场手势

 @param animator 转场动画对象
 @return 转场手势对象
 */
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.dismissPopInteractiveTransition.isPanGestureInteration ? self.dismissPopInteractiveTransition : nil;
}

#pragma mark -
#pragma mark UINavigationControllerDelegate

/**
 push|pop 转场动画

 @param navigationController navigationController
 @param operation navigation 转场类型
 @param fromVC 转场开始VC
 @param toVC 转场结束VC
 @return 转场动画对象
 */
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    if (operation == UINavigationControllerOperationPush)
    {
        return self.presentPushTransitionAnimation;
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        return self.dismissPopTransitionAnimation;
    }
    else
    {
        return nil;
    }
}

/**
 push|pop 转场手势

 @param navigationController navigationController
 @param animationController 执行动画VC
 @return 转场动画对象
 */
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (_operation == UINavigationControllerOperationPush) {
        return self.presentPushInteractiveTransition.isPanGestureInteration ? self.presentPushInteractiveTransition:nil;
    }
    else{
        return self.dismissPopInteractiveTransition.isPanGestureInteration ? self.dismissPopInteractiveTransition:nil;
    }
}

#pragma mark -
#pragma mark SET/GET
-(LeeTransitionAnimation *)presentPushTransitionAnimation{
    if (_presentPushTransitionAnimation == nil) {
        __weak typeof(self) weakSelf = self;
        _presentPushTransitionAnimation = [[LeeTransitionAnimation alloc]initWithDuration:self.duration];
        _presentPushTransitionAnimation.animationBlock = ^(id<UIViewControllerContextTransitioning> contextTransition) {
            [weakSelf setPresentPushAnimation:contextTransition];
        };
    }
    return _presentPushTransitionAnimation;
}
-(LeeTransitionAnimation *)dismissPopTransitionAnimation{
    if (_dismissPopTransitionAnimation == nil) {
        __weak typeof(self) weakSelf = self;
        _dismissPopTransitionAnimation = [[LeeTransitionAnimation alloc]initWithDuration:self.duration];
        _dismissPopTransitionAnimation.animationBlock = ^(id<UIViewControllerContextTransitioning> contextTransition) {
            [weakSelf setDismissPopAnimation:contextTransition];
        };
    }
    return _dismissPopTransitionAnimation;
}
@end

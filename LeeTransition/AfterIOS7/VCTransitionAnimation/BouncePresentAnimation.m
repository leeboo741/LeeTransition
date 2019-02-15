//
//  BouncePresentAnimation.m
//  LeeTransition
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

// @protocol ==> UIViewControllerContextTransitioning

/*
 -(UIView *)containerView; VC切换所发生的view容器，开发者应该将切出的view移除，将切入的view加入到该view容器中。
 -(UIViewController *)viewControllerForKey:(NSString *)key; 提供一个key，返回对应的VC。现在的SDK中key的选择只有UITransitionContextFromViewControllerKey和UITransitionContextToViewControllerKey两种，分别表示将要切出和切入的VC。
 -(CGRect)initialFrameForViewController:(UIViewController *)vc; 某个VC的初始位置，可以用来做动画的计算。
 -(CGRect)finalFrameForViewController:(UIViewController *)vc; 与上面的方法对应，得到切换结束时某个VC应在的frame。
 -(void)completeTransition:(BOOL)didComplete; 向这个context报告切换已经完成。
 */

// @protocol ==> UIViewControllerAnimatedTransitioning

/*
 -(NSTimeInterval)transitionDuration:(id < UIViewControllerContextTransitioning >)transitionContext; 系统给出一个切换上下文，我们根据上下文环境返回这个切换所需要的花费时间（一般就返回动画的时间就好了，SDK会用这个时间来在百分比驱动的切换中进行帧的计算，后面再详细展开）。
 
 -(void)animateTransition:(id < UIViewControllerContextTransitioning >)transitionContext; 在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成。
 */

// @protocol ==> UIViewControllerTransitioningDelegate

/*
 
 在需要VC切换的时候系统会像实现了这个接口的对象询问是否需要使用自定义的切换效果
 
 前两个方法是针对动画切换的，我们需要分别在呈现VC和解散VC时，给出一个实现了UIViewControllerAnimatedTransitioning接口的对象（其中包含切换时长和如何切换）。后两个方法涉及交互式切换
 
-(id< UIViewControllerAnimatedTransitioning >)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;

-(id< UIViewControllerAnimatedTransitioning >)animationControllerForDismissedController:(UIViewController *)dismissed;

-(id< UIViewControllerInteractiveTransitioning >)interactionControllerForPresentation:(id < UIViewControllerAnimatedTransitioning >)animator;

-(id< UIViewControllerInteractiveTransitioning >)interactionControllerForDismissal:(id < UIViewControllerAnimatedTransitioning >)animator;
*/

#import "BouncePresentAnimation.h"

@implementation BouncePresentAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 1. Get controllers from transition context
    // 获取转场上下文中的viewController
    // UITransitionContextToViewControllerKey 转场目标VC
    // UITransitionContextFromViewControllerKey 转场出发VC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for toVC
    // 设置转场目标VC初始位置
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, screenBounds.size.width, screenBounds.size.height);
    
    // 3. Add toVC's view to containerView
    // 将转场目标VC添加至转场容器
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // 4. Do animate now
    // 执行动画
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         [transitionContext completeTransition:YES];
                     }];
}

@end

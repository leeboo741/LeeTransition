//
//  UIViewController+LeeTransition.m
//  LeeTransition
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "UIViewController+LeeTransition.h"
#import <objc/runtime.h>

NSString *const kAnimationKey = @"kAnimationKey";
NSString *const kToAnimationKey = @"kToAnimationKey";

@implementation UIViewController (LeeTransition)
/**
 push 转场动画
 
 @param viewController 转场目标VC
 @param transitionManager 转场动画管理器，统一处理present,dismiss,push,pop转场协议
 */
- (void)lee_pushViewControler:(UIViewController *)viewController withAnimation:(LeeTransitionManager *)transitionManager
{
    // 转场目标不存在 退出
    if (!viewController) {
        return;
    }
    // 管理器不存在 退出
    if (!transitionManager) {
        return;
    }
    // navigationController
    if (self.navigationController) {
        // 指定navigation转场 协议 实现对象 为 转场管理器
        self.navigationController.delegate = transitionManager;
        // 通过 runtime 获取 本VC 绑定的 出场 手势控制器
        LeeInteractiveTransition *toInteractiveTransition = objc_getAssociatedObject(self, &kToAnimationKey);
        // 如果手势控制器存在 将 出场 手势控制器 赋值给 转场控制器的 出场 手势控制器
        if (toInteractiveTransition) {
            [transitionManager setValue:toInteractiveTransition forKey:@"presentPushInteractiveTransition"];
        }
        // 通过 runtime 给转场目标VC 设置 转场管理器
        objc_setAssociatedObject(viewController, &kAnimationKey, transitionManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        // 开启转场
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

/**
 present 转场动画
 
 @param viewController 转场目标VC
 @param transitionManager 转场控制器
 */
- (void)lee_presentViewControler:(UIViewController *)viewController withAnimation:(LeeTransitionManager *)transitionManager
{
    // 转场目标不存在 退出
    if (!viewController) {
        return;
    }
    // 转场控制器不存在 退出
    if (!transitionManager) {
        return;
    }
    //present 动画代理 被执行动画的vc设置代理
    viewController.transitioningDelegate = transitionManager;
    // 获取 本VC 的 出场 手势控制器
    LeeInteractiveTransition *toInteractiveTransition = objc_getAssociatedObject(self, &kToAnimationKey);
    // 出场 手势控制器存在 赋值给 转场控制器的 出场 手势控制器
    if (toInteractiveTransition) {
        [transitionManager setValue:toInteractiveTransition forKey:@"presentPushInteractiveTransition"];
    }
    // 通过 runtime 给转场目标VC 设置 转场管理器
    objc_setAssociatedObject(viewController, &kAnimationKey, transitionManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 开启转场
    [self presentViewController:viewController animated:YES completion:nil];
}

/**
 注册 出场 手势控制器
 
 @param direction 方向
 @param blcok 手势开始回调
 */
- (void)lee_registerToInteractiveTransitionWithDirection:(LeeEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok
{
    // 初始化手势控制器
    LeeInteractiveTransition *interactiveTransition = [[LeeInteractiveTransition alloc] init];
    // 手势开始回调
    interactiveTransition.eventBlcok = blcok;
    // 初始化手势
    [interactiveTransition addEdgePageGestureWithView:self.view direction:direction];
    // runtime 注册 本VC 的 出场 手势控制器
    objc_setAssociatedObject(self, &kToAnimationKey, interactiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 注册 返回手势控制器
 
 @param direction 方向
 @param blcok 手势开始回调
 */
- (void)lee_registerBackInteractiveTransitionWithDirection:(LeeEdgePanGestureDirection)direction eventBlcok:(dispatch_block_t)blcok
{
    // 初始化 手势控制器
    LeeInteractiveTransition *interactiveTransition = [[LeeInteractiveTransition alloc] init];
    // 手势开始回调
    interactiveTransition.eventBlcok = blcok;
    // 初始化手势
    [interactiveTransition addEdgePageGestureWithView:self.view direction:direction];
    
    //判读是否需要返回 然后添加侧滑
    LeeTransitionManager *animator = objc_getAssociatedObject(self, &kAnimationKey);
    if (animator)
    {
        //用kvc的模式  给 animator的backInteractiveTransition 退场赋值
        [animator setValue:interactiveTransition forKey:@"dismissPopInteractiveTransition"];
    }
}
@end

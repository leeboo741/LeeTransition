//
//  LeeTransitionManager.h
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

@interface LeeTransitionManager : NSObject
<
UIViewControllerTransitioningDelegate, // present|dismiss 转场动画 协议
UINavigationControllerDelegate // push|pop 转场动画 协议
>

/**
 转场动画的时间 默认为0.5s
 */
@property (nonatomic,assign) NSTimeInterval duration;

/**
 设置 present|push 转场动画
 
 @param contextTransitioning 转场上下文容器
 */
-(void)setPresentPushAnimation:(id<UIViewControllerContextTransitioning>)contextTransitioning;

/**
 设置 dismiss|pop 转场动画
 
 @param contextTransitioning 转场上下文容器
 */
-(void)setDismissPopAnimation:(id<UIViewControllerContextTransitioning>)contextTransitioning;

@end

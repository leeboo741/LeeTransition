//
//  LeeInteractiveTransition.h
//  LeeTransition
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LeeEdgePanGestureDirection) {
    LeePanEdgeTop    = 0,
    LeePanEdgeLeft,
    LeePanEdgeBottom,
    LeePanEdgeRight
};

@interface LeeInteractiveTransition : UIPercentDrivenInteractiveTransition

/**
 是否满足侧滑手势交互
 */
@property (nonatomic,assign) BOOL isPanGestureInteration;

/**
 转场时的操作 不用传参数的block
 */
@property (nonatomic,copy) dispatch_block_t eventBlcok;

/**
 添加侧滑手势
 
 @param view 添加手势的view
 @param direction 手势的方向
 */
- (void)addEdgePageGestureWithView:(UIView *)view direction:(LeeEdgePanGestureDirection)direction;

@end

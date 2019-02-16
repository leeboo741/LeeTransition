//
//  LeeInteractiveTransition.m
//  LeeTransition
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LeeInteractiveTransition.h"

@interface LeeInteractiveTransition ()

/**
 保存添加手势的view
 */
@property (nonatomic,strong) UIView *gestureView;

/**
 屏幕侧滑手势
 */
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *panGesture;

@end

@implementation LeeInteractiveTransition

- (void)addEdgePageGestureWithView:(UIView *)view direction:(LeeEdgePanGestureDirection)direction
{
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    switch (direction) {
        case LeePanEdgeLeft:
        {
            popRecognizer.edges = UIRectEdgeLeft;
        }
            break;
        case LeePanEdgeTop:
        {
            popRecognizer.edges = UIRectEdgeTop;
        }
            break;
        case LeePanEdgeBottom:
        {
            popRecognizer.edges = UIRectEdgeBottom;
        }
            break;
        case LeePanEdgeRight:
        {
            popRecognizer.edges = UIRectEdgeRight;
        }
            break;
        default:
            break;
    }
    
    self.gestureView = view;
    [self.gestureView addGestureRecognizer:popRecognizer];
}

- (void)handlePopRecognizer:(UIPanGestureRecognizer*)recognizer {
    // 计算用户手指划了多远
    
    CGFloat progress = fabs([recognizer translationInView:self.gestureView].x) / (self.gestureView.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isPanGestureInteration = YES;
            
            if (self.eventBlcok) {
                self.eventBlcok();
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            // 更新 interactive transition 的进度
            [self updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            //            NSLog(@" 打印信息:%f",progress);
            // 完成或者取消过渡
            if (progress > 0.5) {
                [self finishInteractiveTransition];
            }
            else {
                [self cancelInteractiveTransition];
            }
            
            _isPanGestureInteration = NO;
            break;
        }
        default:
            break;
    }
}

@end

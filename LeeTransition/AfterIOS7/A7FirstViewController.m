//
//  A7FirstViewController.m
//  LeeTransition
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "A7FirstViewController.h"
#import "A7SecondViewController.h"
#import "VCTransitionAnimation/BouncePresentAnimation.h"
#import "VCTransitionAnimation/NormalDismissAnimation.h"
#import "VCTransitionAnimation/SwipeInteractiveTransition.h"

@interface A7FirstViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) BouncePresentAnimation * presentAnimation;
@property (nonatomic, strong) NormalDismissAnimation * dismissAnimation;
@property (nonatomic, strong) SwipeInteractiveTransition * transitionController;
@property (nonatomic,assign) UINavigationControllerOperation operation;
@end

@implementation A7FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _presentAnimation = [[BouncePresentAnimation alloc]init];
    _dismissAnimation = [[NormalDismissAnimation alloc]init];
    _transitionController = [[SwipeInteractiveTransition alloc]init];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)presentAction:(id)sender {
    A7SecondViewController * secondVC = [[A7SecondViewController alloc]initWithNibName:@"A7SecondViewController" bundle:nil];
    secondVC.transitioningDelegate = self;
    [self.transitionController wireToViewController:secondVC];
    [self presentViewController:secondVC animated:YES completion:nil];
}
- (IBAction)pushAction:(id)sender {
    A7SecondViewController * secondVC = [[A7SecondViewController alloc]initWithNibName:@"A7SecondViewController" bundle:nil];
    self.navigationController.delegate = self;
    [self.transitionController wireToViewController:secondVC];
    [self.navigationController pushViewController:secondVC animated:YES];
}
#pragma mark -
#pragma mark Present 转场
// 转场动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentAnimation;
}
// 回退动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissAnimation;
}
// 退场手势
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.transitionController.interacting ? self.transitionController : nil;
}
#pragma mark -
#pragma mark Push 转场
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    
    if (operation == UINavigationControllerOperationPush)
    {
        return self.presentAnimation;
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        return self.dismissAnimation;
    }
    else
    {
        return nil;
    }
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (_operation == UINavigationControllerOperationPush) {
        return self.transitionController.interacting ? self.transitionController : nil;
    }
    else{
        return self.transitionController.interacting ? self.transitionController : nil;
    }
}

@end

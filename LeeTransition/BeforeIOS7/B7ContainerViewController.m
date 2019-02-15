//
//  B7ContainerViewController.m
//  LeeTransition
//
//  Created by mac on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "B7ContainerViewController.h"
#import "B7FirstViewController.h"
#import "B7SecondViewController.h"

@interface B7ContainerViewController ()

@property (nonatomic, assign) int currentIndex;

@property (nonatomic, strong) B7FirstViewController * fVC;
@property (nonatomic, strong) B7SecondViewController * sVC;

@end

@implementation B7ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    _fVC = [[B7FirstViewController alloc]initWithNibName:@"B7FirstViewController" bundle:nil];
    _sVC = [[B7SecondViewController alloc]initWithNibName:@"B7SecondViewController" bundle:nil];
    
    NSLog(@"fvc 0-0 ==> %@",NSStringFromCGRect(_fVC.view.frame));
    NSLog(@"svc 0-0 ==> %@",NSStringFromCGRect(_sVC.view.frame));
    
    [self addChildViewController:_sVC];
    [self.view addSubview:_sVC.view];
    
    [self addChildViewController:_fVC];
    [self.view addSubview:_fVC.view];
    
    
    
    NSLog(@"fvc 0-1 ==> %@",NSStringFromCGRect(_fVC.view.frame));
    NSLog(@"svc 0-1 ==> %@",NSStringFromCGRect(_sVC.view.frame));
    
}
-(void)tapAction:(UITapGestureRecognizer *)tapGR{
    NSLog(@"tap");
    if (self.currentIndex == 0) {
        self.currentIndex = 1;
        
        [_fVC willMoveToParentViewController:nil];
        if (![self.childViewControllers containsObject:_sVC]) {
            [self addChildViewController:_sVC];
        }
        if (![self.view.subviews containsObject:_sVC.view]) {
            [self.view addSubview:_sVC.view];
        }
        NSLog(@"fvc 1 ==> %@",NSStringFromCGRect(_fVC.view.frame));
        NSLog(@"svc 1 ==> %@",NSStringFromCGRect(_sVC.view.frame));
        
        __weak id weakSelf = self;
        __weak typeof(_fVC) blockFVC = _fVC;
        __weak typeof(_sVC) blockSVC = _sVC;
        [self transitionFromViewController:_fVC
                          toViewController:_sVC
                                  duration:1
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{}
                                completion:^(BOOL finished) {
                                    [blockFVC.view removeFromSuperview];
                                    [blockFVC removeFromParentViewController];
                                    [blockSVC didMoveToParentViewController:weakSelf];
                                }];
    } else {
        self.currentIndex = 0;
        
        [_sVC willMoveToParentViewController:nil];
        
        if (![self.childViewControllers containsObject:_fVC]) {
            [self addChildViewController:_fVC];
        }
        if (![self.view.subviews containsObject:_fVC.view]) {
            [self.view addSubview:_fVC.view];
        }
        
        NSLog(@"fvc 2 ==> %@",NSStringFromCGRect(_fVC.view.frame));
        NSLog(@"svc 2 ==> %@",NSStringFromCGRect(_sVC.view.frame));
        
        __weak id weakSelf = self;
        __weak typeof(_fVC) blockFVC = _fVC;
        __weak typeof(_sVC) blockSVC = _sVC;
        [self transitionFromViewController:_sVC
                          toViewController:_fVC
                                  duration:1
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{}
                                completion:^(BOOL finished) {
                                    [blockSVC.view removeFromSuperview];
                                    [blockSVC removeFromParentViewController];
                                    [blockFVC didMoveToParentViewController:weakSelf];
                                }];
    }
}

@end

//
//  LeeTransitionToViewController.m
//  LeeTransition
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LeeTransitionToViewController.h"
#import "LeeTransition/UIViewController+LeeTransition.h"

@interface LeeTransitionToViewController ()

@end

@implementation LeeTransitionToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        __weak typeof(self)weakSelf = self;
        [self lee_registerBackInteractiveTransitionWithDirection:LeePanEdgeLeft eventBlcok:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        __weak typeof(self)weakSelf = self;
        [self lee_registerBackInteractiveTransitionWithDirection:LeePanEdgeLeft eventBlcok:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}
- (IBAction)backAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

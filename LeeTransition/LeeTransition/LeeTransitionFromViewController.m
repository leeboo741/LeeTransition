//
//  LeeTransitionFromViewController.m
//  LeeTransition
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LeeTransitionFromViewController.h"
#import "LeeTransitionToViewController.h"
#import "LeeTransition/UIViewController+LeeTransition.h"
#import "LeeTransition/Manager/LeeTransitionManager.h"
#import "LeeTransition/Manager/SubManager/LeeTransitionTestManager.h"

@interface LeeTransitionFromViewController ()

@end

@implementation LeeTransitionFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)presentAction:(id)sender {
    LeeTransitionManager *openDoorAnimation = [[LeeTransitionManager alloc] init];
    openDoorAnimation.duration = 0.5;
    
    LeeTransitionToViewController *openDoorToVc = [[LeeTransitionToViewController alloc] init];
    [self lee_pushViewControler:openDoorToVc withAnimation:openDoorAnimation];
}
- (IBAction)pushAction:(id)sender {
    LeeTransitionTestManager *openDoorAnimation = [[LeeTransitionTestManager alloc] init];
    openDoorAnimation.duration = 0.5;
    
    LeeTransitionToViewController *openDoorToVc = [[LeeTransitionToViewController alloc] init];
    [self lee_presentViewControler:openDoorToVc withAnimation:openDoorAnimation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

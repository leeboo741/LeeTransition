//
//  ViewController.m
//  LeeTransition
//
//  Created by mac on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"
#import "BeforeIOS7/B7ContainerViewController.h"
#import "AfterIOS7/A7FirstViewController.h"
#import "LeeTransition/LeeTransitionFromViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)Before7:(id)sender {
    B7ContainerViewController * b7ContainerViewController = [[B7ContainerViewController alloc]initWithNibName:@"B7ContainerViewController" bundle:nil];
    [self.navigationController pushViewController:b7ContainerViewController animated:YES];
}
- (IBAction)After7:(id)sender {
    A7FirstViewController * a7FirstViewController = [[A7FirstViewController alloc]initWithNibName:@"A7FirstViewController" bundle:nil];
    [self.navigationController pushViewController:a7FirstViewController animated:YES];
}
- (IBAction)LeeTransition:(id)sender {
    LeeTransitionFromViewController * fromViewController = [[LeeTransitionFromViewController alloc]initWithNibName:@"LeeTransitionFromViewController" bundle:nil];
    [self.navigationController pushViewController:fromViewController animated:YES];
}


@end

//
//  ViewController.m
//  LeeTransition
//
//  Created by mac on 2019/2/14.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"
#import "BeforeIOS7/B7ContainerViewController.h"

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
}


@end

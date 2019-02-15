//
//  SwipeInteractiveTransition.h
//  LeeTransition
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwipeInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
- (void)wireToViewController:(UIViewController*)viewController;
@end

NS_ASSUME_NONNULL_END

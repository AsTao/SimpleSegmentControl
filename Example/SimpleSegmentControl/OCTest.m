//
//  OCTest.m
//  SimpleSegmentControl_Example
//
//  Created by Tao on 2018/5/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "OCTest.h"
#import "SimpleSegmentControl-Swift.h"


@implementation OCTest
- (void)test{
    SimpleSegmentControl *control = [[SimpleSegmentControl alloc] init];
    control.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    control.indexChangedHandler = ^(NSInteger index) {
        
    };
}
@end

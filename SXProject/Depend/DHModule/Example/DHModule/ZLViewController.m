//
//  ZLViewController.m
//  DHModule
//
//  Created by 王威 on 10/13/2022.
//  Copyright (c) 2022 王威. All rights reserved.
//

#import "ZLViewController.h"
#import "ServiceProtocol.h"
#import <DHModule/DHModule.h>
#import <DHModule/DHModule-Swift.h>

@interface ZLViewController ()

@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pushA:(id)sender {
    UIViewController *currentVc = [DHRouterUtil getCurrentVc];
    if (currentVc == self) {
        NSLog(@"🍎🍎🍎 %@:: %@", NSStringFromClass([self class]), @"Yes...");
    } else {
        NSLog(@"🍎🍎🍎 %@:: %@", NSStringFromClass([self class]), @"No...");
    }
    
    id<AServiceProtocol> impl = [DHModule implForService:@protocol(AServiceProtocol)];
    impl.backgroudColor = [UIColor greenColor];
    if ([impl isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:(UIViewController *)impl animated:YES];
    }
}
- (IBAction)pushB:(id)sender {
    //    id<BServiceProtocol> impl = [DHModule implForService:@protocol(BServiceProtocol)];
    //    impl.eventName = @"Test";
    //    if ([impl isKindOfClass:[UIViewController class]]) {
    //        [self.navigationController pushViewController:(UIViewController *)impl animated:YES];
    //    }
        
        [DHRouter openURL:@"example://moduleb?eventname=Router" completion:^(id result) {
            if ([result isKindOfClass:[UIViewController class]]) {
                [self.navigationController pushViewController:(UIViewController *)result animated:YES];
            }
        }];
        
        [DHModule deliveryModule:@[@"BModule"] customEvent:@"BEvent" userInfo:@{@"eventId": @"BAction"}];
}
- (IBAction)pushC:(id)sender {
    id<CServiceProtocol> impl = [DHModule implForService:@protocol(CServiceProtocol)];
    impl.backgroudColor = [UIColor redColor];
    if ([impl isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:(UIViewController *)impl animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  UINavigationController+Handler.h
//  ChildishBeautyParent
//
//  Created        on 2017/12/26.
//  Copyright © 2017年 BitInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>

@optional

-(BOOL)navigationShouldPopOnBackButton;//拦截返回按钮点击事件

@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end

@interface UINavigationController (Handler)


#pragma mark - 边缘手势

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer;

@end

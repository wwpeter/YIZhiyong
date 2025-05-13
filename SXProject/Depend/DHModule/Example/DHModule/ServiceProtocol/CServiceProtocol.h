//
//  CServiceProtocol.h
//  DHModuleExample
//
//  Created by iblue on 2017/7/13.
//  Copyright © 2017年 jiangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CServiceProtocol <DHServiceProtocol>

/**
 背影颜色
 */
@property (nonatomic, strong) UIColor *backgroudColor;

@end

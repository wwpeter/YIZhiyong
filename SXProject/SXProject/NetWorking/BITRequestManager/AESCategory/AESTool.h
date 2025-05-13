//
//  AESTool.h
//  RainbowCity
//
//  Created by bocai on 16/4/5.
//  Copyright © 2016年 clf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESTool : NSObject


-(NSDictionary *)AES256DecryptWithKey :(NSString *)key ResContent :(NSDictionary *)AESDic;

@end

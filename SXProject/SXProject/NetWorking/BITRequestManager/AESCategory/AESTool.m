//
//  AESTool.m
//  RainbowCity
//
//  Created by bocai on 16/4/5.
//  Copyright © 2016年 clf. All rights reserved.
//

#import "AESTool.h"
#import "NSData+Encryption.h"
#import "NSString+Hash.h"
@implementation AESTool

-(NSDictionary *)AES256DecryptWithKey :(NSString *)key ResContent :(NSDictionary *)AESDic{
    
    NSString *content = [AESDic objectForKey:@"content"];
    NSString *md5Keys = [key md5String];
    NSData *decryptionData = [NSData stringToByte:content];
    NSData *contentData = [decryptionData AES256NewDecryptWithKey:md5Keys];
    NSDictionary *contentJSON = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingAllowFragments error:nil];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:AESDic];
    [dict setObject:contentJSON forKey:@"content"];
    return dict;

}


@end

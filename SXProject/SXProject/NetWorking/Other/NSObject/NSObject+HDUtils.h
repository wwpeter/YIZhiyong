//
//  NSObject+HDUtils.h
//  piaojulicai-ios
//
//2017/12/8.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Dictionary(temp) (NSDictionary*)temp

@interface NSObject (HDUtils)

#pragma mark - String
- (BOOL)isString;
- (BOOL)isNotEmptyString;

-(NSString *)showThousandth;

-(NSString *)showThousandthWithNoBack;

-(NSString *)removeThousandth;
//不带小数点
-(NSString *)removeThousandthWithNoBack;

//保留几位小数且不带四舍五入
-(NSString *)point:(int)point;


#pragma mark - Dictionary
- (BOOL)isDictionary;
- (BOOL)isNotEmptyDictionary;


#pragma mark - Label
- (void)sizeToFitLabelWidth;
- (void)sizeToFitLabelHeight;
- (void)sizeToFitLabelHeight:(CGFloat)width;
- (void)sizeToFitLabelHeight:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;
+ (CGFloat)sizeToFitLabelHeight:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;
- (CGFloat)labelHeight;
- (CGFloat)textfieldHeight;

#pragma mark - imageView
- (void)sizeToFitImageViewSize;

#pragma mark - button
- (void)sizeToFitButtonWidth;

#pragma mark - image


#pragma mark - UIView
- (UIImage *)snapshotImage;
- (UIImage *)setImageWithTintColor:(UIColor *)color;



- (void)removeAllSubView;

@end

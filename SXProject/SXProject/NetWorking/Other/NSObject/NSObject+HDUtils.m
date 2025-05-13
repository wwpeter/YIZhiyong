//
//  NSObject+HDUtils.m
//  piaojulicai-ios
//
//2017/12/8.
//  Copyright © 2017年 . All rights reserved.
//

#import "NSObject+HDUtils.h"
#import <Masonry/Masonry.h>
#import "HDUtils.h"
#import "BITCommonMacro.h"

@implementation NSObject (HDUtils)

#pragma mark - string
- (BOOL)isString{
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isNotEmptyString{
    if (self!=nil && [self isString]) {
        NSString *string = (NSString*)self;
        if (string.length>0) {
            return YES;
        }
    }
    return NO;
}

//带两位小数点
-(NSString *)showThousandth
{
    if (self!=nil && [self isString]) {
        NSString *str = (NSString*)self;

        if(!str || [str floatValue] == 0)
        {
            return @"0.00";
        }
        else if([str floatValue] < 1)
        {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@",##0.00;"];
            return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
        }
        NSArray *array = [str componentsSeparatedByString:@","];
        if (array.count>1) {
            NSString *string = [str stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@",###.00;"];
            return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[string doubleValue]]];
        }
        
        else
        {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setPositiveFormat:@",###.00;"];
            return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
        }    }
    return @"";
}


//不带两位小数点
-(NSString *)showThousandthWithNoBack
{
    if (self!=nil && [self isString]) {
        NSString *str = (NSString*)self;

        if(!str || [str floatValue] == 0){
            return str;
        }else{
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *num = [numberFormatter numberFromString:str];
            return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[num doubleValue]]];
        }
    }
    return @"";
}

-(NSString *)removeThousandth
{
    if (self!=nil && [self isString]) {
        NSString *str = (NSString*)self;

        if ([str containsString:@","] || [str containsString:@".00"]) {
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            [formatter setPositiveFormat:@",##0.00;"];
            return [formatter numberFromString:str].stringValue;
        }else{
            return str;
        }
    }
    return @"";
}

-(NSString *)removeThousandthWithNoBack
{
    if (self!=nil && [self isString]) {
        NSString *str = (NSString*)self;
        
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        [formatter setPositiveFormat:@",###;"];
        return [formatter numberFromString:str].stringValue;
    }
    return @"";
    
}

-(NSString *)point:(int)point{
    
    if (self!=nil && [self isString]) {
        NSString *str = (NSString*)self;
        
        NSString *strOne = [NSString stringWithFormat:@"%.9f",str.doubleValue];
        NSArray *array = [strOne componentsSeparatedByString:@"."];
        NSString *strThree= [array[1] substringToIndex:point];
        NSString *needStr = [NSString stringWithFormat:@"%@.%@",array[0],strThree];
        return needStr;
    }
    return @"";
}


#pragma mark - dictionary
- (BOOL)isDictionary{
    if ([self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}


- (BOOL)isNotEmptyDictionary{
    if (self!=nil && [self isDictionary]) {
        return YES;
    }
    return NO;
}


- (void)sizeToFitLabelWidth{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel*)self;
        [label sizeToFit];
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(label.width);
        }];
    }
}



- (void)sizeToFitLabelHeight{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel*)self;
        CGSize size = [HDUtils sizeForText:label.text withWidth:SAFEAREA_WIDTH withFont:label.font];
        label.height = size.height;
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
        }];
    }
}

- (void)sizeToFitLabelHeight:(CGFloat)width{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel*)self;
        CGSize size = [HDUtils sizeForText:label.text withWidth:width withFont:label.font];
        label.height = size.height;
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
        }];
    }
}

- (void)sizeToFitLabelHeight:(CGFloat)width lineSpacing:(CGFloat)lineSpacing{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel*)self;
        CGSize size = [HDUtils sizeForText:label.text withWidth:width withFont:label.font lineSpacing:lineSpacing];
        label.height = size.height;
        [label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
        }];
    }
}

- (void)sizeToFitButtonWidth{
//    if ([self isKindOfClass:[HDButton class]]) {
////        HDButton *button = (HDButton*)self;
////        if (button.currentImage) {
////            [button sizeToFit];
////            [button mas_updateConstraints:^(MASConstraintMaker *make) {
////                make.width.mas_equalTo(button.width);
////            }];
////        }else{
////            CGSize buttonSize = [button hdSizeToFit];
////            [button mas_updateConstraints:^(MASConstraintMaker *make) {
////                make.width.mas_equalTo(buttonSize.width);
////            }];
////        }
//        
//    }else
        if ([self isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton*)self;
        if (button.currentImage) {
            [button sizeToFit];
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(button.width);
            }];
        }else{
            CGSize buttonSize;
            if (button.currentAttributedTitle) {
                buttonSize = [HDUtils sizeForText:button.currentAttributedTitle.string withWidth:SAFEAREA_WIDTH withFont:button.titleLabel.font];
            }else{
                buttonSize = [HDUtils sizeForText:button.currentTitle withWidth:SAFEAREA_WIDTH withFont:button.titleLabel.font];
            }
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(buttonSize.width);
            }];
        }
    }
}

- (CGFloat)labelHeight{
    if (![self isKindOfClass:[UILabel class]]) {
        return 0;
    }
    UILabel *label = (UILabel*)self;
    if ([label.font.fontName isEqualToString:@"DINMittelschriftStd"]) {
        return label.font.pointSize+2;
    }
    return label.font.pointSize;
}

- (CGFloat)textfieldHeight{
    if (![self isKindOfClass:[UITextField class]]) {
        return 0;
    }
    UITextField *textfield = (UITextField*)self;
    if ([textfield.font.fontName isEqualToString:@"DINMittelschriftStd"]) {
        return textfield.font.pointSize+2;
    }
    return textfield.font.pointSize;
}


- (void)sizeToFitImageViewSize{
    if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView*)self;
        [imageView sizeToFit];
        [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(imageView.width);
            make.height.mas_equalTo(imageView.height);
        }];
    }
    
}


- (UIImage *)snapshotImage
{
    if ([self isKindOfClass:[UIView class]]) {
        UIView *view = (UIView*)self;
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
        } else {
            [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    return nil ;
}
-(UIImage *)setImageWithTintColor:(UIColor *)color
{
    if ([self isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage*)self;

        CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
        [color setFill];
        UIRectFill(bounds);
        [image  drawInRect:bounds
                blendMode:kCGBlendModeDestinationIn
                    alpha:1.0f];
        UIImage *tintImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return tintImage;
    }
    return nil;
}

- (void)removeAllSubView{
    if ([self isKindOfClass:[UIView class]]) {
        UIView *view = (UIView*)self;

        NSArray *arraySubView = [NSArray arrayWithArray:view.subviews];
        for(UIView *subView in arraySubView)
        {
            if(subView.subviews.count != 0)
            {
                [subView removeAllSubView];
            }
            [subView removeFromSuperview];
        }
    }
}

@end

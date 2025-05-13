//
//  HDUtils.m
//  piaojulicai-ios
//
//2017/11/29.
//  Copyright © 2017年 . All rights reserved.
//

#import "HDUtils.h"
#import "NSObject+HDUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "UIView+HDCornerBorder.h"
#import <Masonry/Masonry.h>
#import "BITCommonMacro.h"

@implementation HDUtils

+(UIWindow *)getLevelNormalWindwow
{
    NSArray *windows = [[UIApplication sharedApplication] windows];

    for(UIWindow * tmpWin in windows)
    {
        if (tmpWin.windowLevel == UIWindowLevelNormal)
        {
            UIViewController *result = nil;
            UIView *frontView = [[tmpWin subviews] objectAtSafeIndex:0];
            id nextResponder = [frontView nextResponder];
            
            if ([nextResponder isKindOfClass:[UIViewController class]])
                result = nextResponder;
            else
                result = tmpWin.rootViewController;
            
            NSArray *cv = [result childViewControllers];
            NSLog(@"%@",cv);
            if(cv && [cv isKindOfClass:[NSArray class]] && cv.count > 0)
            {
                return tmpWin;
            }
        }
    }
    return nil;
}


#pragma mark- queue
/**
 在globalQueue中异步执行
 
 @param queue globalQueue
 */
+ (void)executeGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

/**
 在globalQueue中延迟异步执行
 
 @param queue   globalQueue
 @param seconds 延迟时间
 */
+ (void)executeGlobalQueue:(void (^)())queue afterSeconds:(CGFloat)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

/**
 在主线程中异步执行
 
 @param queue mainQueue
 */
+ (void)executeMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

/**
 在主线程中延迟异步执行
 
 @param queue   mainQueue
 @param seconds 延迟时间
 */
+ (void)executeMainQueue:(void (^)())queue afterSeconds:(CGFloat)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), queue);
}
+ (CGSize)sizeForText:(NSString*)text withWidth:(CGFloat)width withFont:(UIFont*)font{
    if(![text isKindOfClass:NSString.class]){
        return CGSizeMake(0, 0);
    }
    UILabel *gettingSizeLabel = [HDSingletonLabel sharedInstance];
    gettingSizeLabel.font = font;
    gettingSizeLabel.text = text;
    gettingSizeLabel.numberOfLines = 0;
    gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize maximumLabelSize = CGSizeMake(width, MAXFLOAT);
    CGSize expectSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
    if ([font.fontName isEqualToString:@"DINMittelschriftStd"]) {
        return CGSizeMake(expectSize.width, expectSize.height+2);
    }
    return expectSize;
}
/**
 价格转换为每隔3位用逗号分割
 show 是否显示小数点后面
 */
+ (NSString *)changePriceWithNumber:(double)value showPoint:(BOOL)show {
    NSString *valueStr = @"";
    NSString *format = @"";
    if (show) {
        valueStr = [NSString stringWithFormat:@"%.2f", value];
        format = @",###.##";
    } else {
        valueStr = [NSString stringWithFormat:@"%.f", value];
        format = @",###";
    }
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:valueStr];
    NSNumberFormatter *numberFormatter =   [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:format];
    return [numberFormatter stringFromNumber:decNumber];
}



+(void)setLabelSpace:(UILabel*)label withSpace:(CGFloat)space withFont:(UIFont*)font{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
    };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:label.text attributes:dic];
    label.attributedText = attributeStr;
}

+ (CGSize)sizeForText:(NSString*)text withWidth:(CGFloat)width withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing{
    if(![text isKindOfClass:NSString.class]){
        return CGSizeMake(0, 0);
    }
    UILabel *gettingSizeLabel = [HDSingletonLabel sharedInstance];
    gettingSizeLabel.font = font;
    gettingSizeLabel.text = text;
    gettingSizeLabel.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attributedString addAttributes:@{
                                      NSParagraphStyleAttributeName:paragraphStyle,
                                      } range:NSMakeRange(0, attributedString.length)];
    gettingSizeLabel.attributedText =  attributedString;
    CGSize maximumLabelSize = CGSizeMake(width, MAXFLOAT);
    CGSize expectSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
    
    return expectSize;
}
    

+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andColor:(UIColor *)color{
    
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    if ([allStr isNotEmptyString]) {
        NSRange rangeOne = [allStr rangeOfString:changeStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:rangeOne];
    }
    return attributedStr;
}





+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andFont:(UIFont *)font{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    if ([allStr isNotEmptyString]) {

        NSRange rangeOne = [allStr rangeOfString:changeStr];
        [attributedStr addAttribute:NSFontAttributeName value:font range:rangeOne];
    }
    return attributedStr;
}

+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andFont:(UIFont *)font color:(UIColor *)color{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    NSRange rangeOne = [allStr rangeOfString:changeStr];
    [attributedStr addAttribute:NSFontAttributeName value:font range:rangeOne];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:rangeOne];
    return attributedStr;
}

+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andColor:(UIColor *)color andFont:(UIFont *)font withSpace:(CGFloat)space{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
    };
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:allStr attributes:dic];
//    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    if ([allStr isNotEmptyString]) {
        NSRange rangeOne = [allStr rangeOfString:changeStr];
        [attributedStr addAttribute:NSFontAttributeName value:font range:rangeOne];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:rangeOne];
    }
    return attributedStr;
}

//改变字体颜色大小，字符范围不一样
+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeColorStr:(NSString *)changeColorStr andChangeFontStr:(NSString *)changeFontStr andColor:(UIColor *)color andFont:(UIFont *)font{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    if ([allStr isNotEmptyString]) {
        NSRange rangeOne = [allStr rangeOfString:changeColorStr];
        NSRange rangeTwo = [allStr rangeOfString:changeFontStr];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:rangeOne];
        [attributedStr addAttribute:NSFontAttributeName value:font range:rangeTwo];
    }
    return attributedStr;
}


+ (NSString*)convertDictionaryToString:(NSDictionary *)paramters{
    if (!paramters) {
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramters
                                                       options:0
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        NSMutableString *convertString = [[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *character = nil;
        for (int i = 0; i < convertString.length; i ++) {
            character = [convertString substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"\\"])
                [convertString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        return convertString;
    }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//是否是汉字字符
+ (BOOL)isChineseCharacter:(NSString*)string{
    if(string.length>0){
        unichar c = [string characterAtIndex:0];
        if (c >=0x4E00 && c <=0x9FFF)
        {
            return YES;
        }
    }
    return NO;
}

//MD5加密
+(NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

//sha1加密方式
+ (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    //NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+(NSString *)base64EncodeString:(NSString *)string
{
    //1.先把字符串转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码，返回编码后的字符串
    return [data base64EncodedStringWithOptions:0];
}
//base64data数据转换UIimage
+ (UIImage *)stringToImage:(NSString *)strImgDataNew {
    //strImgDataNew 为base64 NSString
    
    //进行首尾空字符串的处理
    strImgDataNew = [strImgDataNew stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    
    //进行空字符串的处理
    strImgDataNew = [strImgDataNew stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    //进行换行字符串的处理
    strImgDataNew = [strImgDataNew stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //去掉头部的前缀//data:image/jpeg;base64, （可根据实际数据情况而定，如果数据有固定的前缀，就执行下面的方法，如果没有就注销掉或删除掉）
    if([strImgDataNew containsString:@"data:image/jpeg;base64,"]) {
        strImgDataNew = [strImgDataNew substringFromIndex:23];
    }else if([strImgDataNew containsString:@"data:image/png;base64,"]) {
        strImgDataNew = [strImgDataNew substringFromIndex:22];
    }
//    strImgDataNew = [strImgDataNew stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@""]];
//    strImgDataNew = [strImgDataNew stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"data:image/png;base64,"]];
//    strImgDataNew = [strImgDataNew substringFromIndex:23];   //23 是根据前缀的具体字符长度而定的。
    
    NSString*encodedImageStr = strImgDataNew;
    
    //进行字符串转data数据 -------NSDataBase64DecodingIgnoreUnknownCharacters
    NSData *decodedImgData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    //把data数据转换成图片内容
    UIImage*decodedImage = [UIImage imageWithData:decodedImgData];
    
    return decodedImage;
    
}
+ (BOOL)containChineseCharacter:(NSString*)string{
    BOOL contain = NO;
    for(int i=0;i<string.length;i++){
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        if([HDUtils isChineseCharacter:subString]){
            return YES;
        }
    }
    return contain;
}
//UIlabel
+(UILabel *)setLabNoSubViewFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text{
    UILabel *lab = [[UILabel alloc]init];
    lab.font = font;
    lab.textColor = color;
    lab.text = text;
    return lab;
}
//UIlabel subView
+(UILabel *)setLabFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text SubView:(id)subView{
    UILabel *lab = [[UILabel alloc]init];
    lab.font = font;
    lab.textColor = color;
    lab.text = text;
    [subView addSubview:lab];
    return lab;
}

//UIButton title
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text SubView:(id)subView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [subView addSubview:btn];
    return btn;

}

//UIButton title color SelectTextColor BgImg SelectBgImg
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color SelectTextColor:(UIColor *)selectColor Text:(NSString *)text BgImg:(UIImage *)img SelectBgImg:(UIImage *)selectBgImg SubView:(id)subView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setBackgroundImage:selectBgImg forState:UIControlStateSelected];
    if (subView) {
        [subView addSubview:btn];
    }
    return btn;

}
//UIButton title color  BgImg
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color  Text:(NSString *)text BgImg:(NSString *)imgStr  SubView:(id)subView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    if (subView) {
        [subView addSubview:btn];
    }
    return btn;

}
//UIButton title color Img
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color  Text:(NSString *)text img:(NSString *)imgStr  SubView:(id)subView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    if (subView) {
        [subView addSubview:btn];
    }
    return btn;

}

//UIButton title
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color SelectTextColor:(UIColor *)selectColor Text:(NSString *)text SubView:(id)subView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn setTitle:text forState:UIControlStateNormal];
    [subView addSubview:btn];
    return btn;

}
//UIButton title  bgColor cornerRadius
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color bgColor:(UIColor *)bgColor Text:(NSString *)text CornerRadius:(CGFloat )cornerRadius SubView:(id)subView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setBackgroundColor:bgColor];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn addCornerWithCornerRadius:cornerRadius];
    [subView addSubview:btn];
    return btn;
}
//UIButton title   cornerRadius
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color  Text:(NSString *)text CornerRadius:(CGFloat )cornerRadius SubView:(id)subView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn addCornerWithCornerRadius:cornerRadius];
    [subView addSubview:btn];
    return btn;
}
//UIButton img
+(UIButton *)setBtnImg:(NSString *)imgStr SubView:(id)subView{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imgStr.length) {        
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    }
    else{
        [btn setBackgroundColor:[UIColor lightGrayColor]];
    }
    [subView addSubview:btn];
    return btn;
}

//UIButton bgimg
+(UIButton *)setBtnBgImg:(NSString *)imgStr SubView:(id)subView{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imgStr.length) {
//        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    }
    else{
        [btn setBackgroundColor:[UIColor clearColor]];
    }
    [subView addSubview:btn];
    return btn;
}







//UIButton img SelectImg
+(UIButton *)setBtnImg:(NSString *)imgStr BtnSelectImg:(NSString *)imgSelectStr SubView:(id)subView{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgSelectStr] forState:UIControlStateSelected];
     btn.selected = NO;
    [subView addSubview:btn];
    return btn;
}


//UIButton bgColor
+(UIButton *)setBtnBgColor:(UIColor *)bgColor SubView:(id)subView {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundColor:bgColor];
    [subView addSubview:btn];
    return btn;
}

//img
+(UIImageView *)setImg:(NSString *)imgStr SubView:(id)subView{
    UIImageView * img = [[UIImageView alloc]init];
    if (imgStr.length) {
        img.image = [UIImage imageNamed:imgStr];
    }else{
        img.backgroundColor = [UIColor lightGrayColor];
//        img.backgroundColor = [UIColor clearColor];
    }
    [subView addSubview:img];
    return img;
}
//View边框圆角
+(void)setView:(UIView *)bgView LayerBorderWidth:(CGFloat)borderWidth CornerRadius:(CGFloat)cornerRadius BorderColor:(UIColor *)borderColor{
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius =cornerRadius;
    bgView.layer.borderWidth = borderWidth;
    bgView.layer.borderColor = [borderColor CGColor];
}
//背景View
+(UIView *)setViewBgColor:(UIColor *)color SubView:(id)subView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    [subView addSubview:view];
    return view;
}
//背景图片View
+(UIView *)setViewBgImg:(NSString *)imgStr SubView:(id)subView{
    UIView *view = [[UIView alloc]init];
    UIImage *image = [UIImage imageNamed:imgStr];
    view.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
    view.layer.backgroundColor = [UIColor clearColor].CGColor;
    [subView addSubview:view];
    return view;
}


//背景View带默认阴影圆角
+(UIView *)setViewBgColorDefaultCornerRadiusShadowSubView:(id)subView Frame:(CGRect)frame{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [subView addSubview:view];
    [view createDefaultCornerRadiusShadowWithCornerRadius];
    return view;
}
//背景View带默认阴影圆角 shadowColor
+(UIView *)setViewBgColorDefaultCornerRadiusShadowSubView:(id)subView Frame:(CGRect)frame shadowColor:(UIColor *)shadowColor{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [subView addSubview:view];
    [view createDefaultCornerRadiusShadowWithCornerRadiusShadowColor:shadowColor];
    return view;
}

//背景View带默认阴影圆角 shadowColor cornerRadius
+(UIView *)setViewBgColorDefaultCornerRadiusShadowSubView:(id)subView Frame:(CGRect)frame shadowColor:(UIColor *)shadowColor cornerRadius:(CGFloat )cornerRadius{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [subView addSubview:view];
    [view createDefaultCornerRadiusShadowWithCornerRadiusShadowColor:shadowColor cornerRadius:cornerRadius];
    return view;
}
//UITextField
+(UITextField *)setTFFont:(UIFont *)font TextColor:(UIColor *)color SubView:(id)subView{
    UITextField *textF = [[UITextField alloc]init];
    textF.font = font;
    textF.textColor = color;
    textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    textF.returnKeyType = UIReturnKeyDone;
    [subView addSubview:textF];
    return textF;
}

//UITextField redius bgColor
+(UITextField *)setTFFont:(UIFont *)font TextColor:(UIColor *)color SubView:(id)subView CornerRadius:(CGFloat)redius bgColor:(UIColor *)bgColor{
    UITextField *textF = [[UITextField alloc]init];
    textF.font = font;
    textF.textColor = color;
    [textF addCornerWithCornerRadius:redius];
    textF.backgroundColor = bgColor;
    [subView addSubview:textF];
    return textF;
}



+(CGFloat)FFLabel:(UILabel *)labell AndLineSpacing:(float)lineSpacing LabWidth:(CGFloat)width
{
    //富文本设置文字行间距
    NSMutableAttributedString *attributedString;
    if (labell.attributedText) {
        attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:labell.attributedText];;
    }else{
        attributedString = [[NSMutableAttributedString alloc]initWithString:labell.text];;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labell.text.length)];
    
    labell.attributedText = attributedString;
    //调节高度
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    CGSize labelSize = [labell sizeThatFits:size];
    CGFloat introHeight = labelSize.height;
    [labell mas_updateConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(introHeight);
     }];
    
    return introHeight;
}

+(CGSize)fuwenbenLabel:(UILabel *)labell AndLineSpacing:(float)lineSpacing wordSpaceing:(float)wordSpacing
{
    //富文本设置文字行间距
    NSMutableAttributedString *attributedString;
    if (labell.attributedText) {
        attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:labell.attributedText];;
    }else{
        attributedString = [[NSMutableAttributedString alloc]initWithString:labell.text];;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSKernAttributeName value:@(wordSpacing) range:NSMakeRange(0, labell.text.length)];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labell.text.length)];
    
    labell.attributedText = attributedString;
    //调节高度
    CGSize size = CGSizeMake(SAFEAREA_WIDTH, 500000);
    
    CGSize labelSize = [labell sizeThatFits:size];
    
    return labelSize;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    label.numberOfLines = 0;
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}




//获取钱小数点整数部分,不需要四舍五入的
+(NSString *)getIntValue:(NSString *)money{
    
    NSString *needStr = nil;
    NSArray *array = [money componentsSeparatedByString:@"."];
    needStr = array[0];
    return needStr;
}

+(NSString*)getCurrentTimeYYYY_MM_DD{
    
    NSDateFormatter *fromatter = [[NSDateFormatter alloc]init];
    [fromatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dataTime = [fromatter stringFromDate:[NSDate date]];
    
    return dataTime;
}

+(NSString*)getCurrentTimeMMddHHmm{
    
    NSDateFormatter *fromatter = [[NSDateFormatter alloc]init];
    [fromatter setDateFormat:@"MM/dd HH:mm"];
    NSString *dataTime = [fromatter stringFromDate:[NSDate date]];
    
    return dataTime;
}


+ (BOOL)containsString:(NSString*)string inString:(NSString*)longString{
    NSRange range = [longString rangeOfString:string];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}
+(NSDate*)dateWithString:(NSString*)dateString andFomatter:(NSString*)fomatter
{
    NSDateFormatter * dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = fomatter;
    NSDate *date = [dateF dateFromString:dateString];
    
    return date;
}

@end

@implementation HDSingletonLabel

+ (HDSingletonLabel *)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[self alloc] initSingleton];
    });
    return sharedInstance;
}

- (instancetype)initSingleton{
    self = [super init];
    if(self){
    }
    return self;
}

- (instancetype)init{
    return [HDSingletonLabel sharedInstance];
}

@end


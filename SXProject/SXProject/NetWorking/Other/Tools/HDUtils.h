//
//  HDUtils.h
//  piaojulicai-ios
//
//2017/11/29.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <BITCategories/BITFDCategories.h>

@interface HDUtils : NSObject
@property (nonatomic,copy) void(^clickAction)(NSString* btnStr);

+(UIWindow *)getLevelNormalWindwow;
#pragma mark- queue
/**
 在globalQueue中执行
 
 @param queue globalQueue
 */
+ (void)executeGlobalQueue:(void (^)())queue;

/**
 在globalQueue中延迟执行
 
 @param queue   globalQueue
 @param seconds 延迟时间
 */
+ (void)executeGlobalQueue:(void (^)())queue afterSeconds:(CGFloat)seconds;

/**
 在主线程中执行
 
 @param queue mainQueue
 */
+ (void)executeMainQueue:(void (^)())queue;

/**
 在主线程中延迟执行
 
 @param queue   mainQueue
 @param seconds 延迟时间
 */
+ (void)executeMainQueue:(void (^)())queue afterSeconds:(CGFloat)seconds;

/**
 md5加密

 @param input 加密内容
 @return 加密后内容
 */
+ (NSString *)md5:(NSString *) input;

/**
 sha1加密方式

 @param input 加密内容
 @return 加密后内容
 */
+ (NSString *)sha1:(NSString *)input;

/**
 base64编码

 @param string 待编码内容
 @return 编码后内容
 */
+ (NSString *)base64EncodeString:(NSString *)string;
//base64data数据转换UIimage
+ (UIImage *)stringToImage:(NSString *)strImgDataNew;
/**
 把字典转换成字符串
 
 @param paramters 待转字典
 @return 字符串
 */
+ (NSString*)convertDictionaryToString:(NSDictionary *)paramters;

/**
 把字符串转换成字典

 @param jsonString 待转字符串
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 字符串中是否包含中文
 
 @param string 字符串
 @return 结果
 */
+ (BOOL)containChineseCharacter:(NSString*)string;

/**
 判断特殊字符

 @param content 内容
 @return 结果
 */
+(BOOL)JudgeTheillegalCharacter:(NSString *)content;

/**
 获取当前时间

 @return 当前时间
 */
+(NSString*)getCurrentTimeYYYY_MM_DD;

/**
 价格转换为每隔3位用逗号分割
 show 是否显示小数点后面
 */
+ (NSString *)changePriceWithNumber:(double)value showPoint:(BOOL)show;
/**
 文字占用区域

 @param text text
 @param width 最大宽度
 @param font 字体
 @return CGSize
 */
+ (CGSize)sizeForText:(NSString*)text withWidth:(CGFloat)width withFont:(UIFont*)font;

+ (CGSize)sizeForText:(NSString*)text withWidth:(CGFloat)width withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing;

+(void)setLabelSpace:(UILabel*)label withSpace:(CGFloat)space withFont:(UIFont*)font;

/**
 NSAttributedString

 @param allStr 整体文字
 @param changeStr 改变文字
 @param color 改变颜色
 @return NSAttributedString
 */
+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andColor:(UIColor *)color;


/**
 NSAttributedString
 
 @param allStr 整体文字
 @param changeStr 改变文字
 @param font 改变字体
 @return NSAttributedString
 */
+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andFont:(UIFont *)font;

/**
 NSAttributedString
 
 @param allStr 整体文字
 @param changeStr 改变文字
 @param font 改变字体
 @param 加中划线
 @return NSAttributedString
 
 */
//+ (NSAttributedString*)attributesUnderCenterLineWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andFont:(UIFont *)font;

/**
 NSAttributedString
 @param allStr 整体文字
 @param changeStr 改变文字
 @param font 改变字体
 @param color 改变颜色
 @return NSAttributedString
 */
+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andFont:(UIFont *)font color:(UIColor *)color;
/**
 NSAttributedString
 @param allStr 整体文字
 @param changeStr 改变文字
 @param font 改变字体
 @param color 改变颜色
 @param space 行间距
 @return NSAttributedString
 */
+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeStr:(NSString *)changeStr andColor:(UIColor *)color andFont:(UIFont *)font withSpace:(CGFloat)space;

/**
 改变行间距和字间距
 @param labell label
 @param lineSpacing 行间距
 @param wordSpacing 字间距
 @return 文本大小
 */
+(CGSize)fuwenbenLabel:(UILabel *)labell AndLineSpacing:(float)lineSpacing wordSpaceing:(float)wordSpacing;
+(CGFloat)FFLabel:(UILabel *)labell AndLineSpacing:(float)lineSpacing LabWidth:(CGFloat)width;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

//UIButton bgColor
+(UIButton *)setBtnBgColor:(UIColor *)bgColor SubView:(id)subView;

//UIButton bgimg
+(UIButton *)setBtnBgImg:(NSString *)imgStr SubView:(id)subView;

+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color  Text:(NSString *)text BgImg:(NSString *)imgStr  SubView:(id)subView;

//UIButton title color Img
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color  Text:(NSString *)text img:(NSString *)imgStr  SubView:(id)subView;
//UIlabel
+(UILabel *)setLabNoSubViewFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text;
//UIlabel subView
+(UILabel *)setLabFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text SubView:(id)subView;
//UIButton title
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text SubView:(id)subView;
//UIButton title
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color SelectTextColor:(UIColor *)selectColor Text:(NSString *)text SubView:(id)subView;
//UIButton title color SelectTextColor BgImg SelectBgImg
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color SelectTextColor:(UIColor *)selectColor Text:(NSString *)text BgImg:(UIImage *)img SelectBgImg:(UIImage *)selectBgImg SubView:(id)subView;
//UIButton img
+(UIButton *)setBtnImg:(NSString *)imgStr SubView:(id)subView;
//UIButton img SelectImg
+(UIButton *)setBtnImg:(NSString *)imgStr BtnSelectImg:(NSString *)imgSelectStr SubView:(id)subView;


//UIButton title  bgColor cornerRadius
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color bgColor:(UIColor *)bgColor Text:(NSString *)text CornerRadius:(CGFloat )cornerRadius SubView:(id)subView;

//UIButton title   cornerRadius
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color  Text:(NSString *)text CornerRadius:(CGFloat )cornerRadius SubView:(id)subView;

//img
+(UIImageView *)setImg:(NSString *)imgStr SubView:(id)subView;

//UIButton title Highlighted 
+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text HighlightedText:(NSString *)highlightedtext SubView:(id)subView;

//View边框圆角
+(void)setView:(UIView *)bgView LayerBorderWidth:(CGFloat)borderWidth CornerRadius:(CGFloat)cornerRadius BorderColor:(UIColor *)borderColor;

+(UIButton *)setBtnFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)text bgColor:(UIColor *)bgColor target:(id)target action:(SEL)action SubView:(id)subView;

//背景View
+(UIView *)setViewBgColor:(UIColor *)color SubView:(id)subView;
//背景图片View
+(UIView *)setViewBgImg:(NSString *)imgStr SubView:(id)subView;
//背景View带默认阴影圆角
+(UIView *)setViewBgColorDefaultCornerRadiusShadowSubView:(id)subView Frame:(CGRect)frame;
//背景View带默认阴影圆角 shadowColor
+(UIView *)setViewBgColorDefaultCornerRadiusShadowSubView:(id)subView Frame:(CGRect)frame shadowColor:(UIColor *)shadowColor;
+(UIView *)setViewBgColorDefaultCornerRadiusShadowSubView:(id)subView Frame:(CGRect)frame shadowColor:(UIColor *)shadowColor cornerRadius:(CGFloat )cornerRadius;
//UITextField
+(UITextField *)setTFFont:(UIFont *)font TextColor:(UIColor *)color SubView:(id)subView;
//UITextField redius bgColor
+(UITextField *)setTFFont:(UIFont *)font TextColor:(UIColor *)color SubView:(id)subView CornerRadius:(CGFloat)redius bgColor:(UIColor *)bgColor;


/**
 判断字符串中是否包含

 @param string 包含
 @param longString 字符串
 @return 结果
 */
+ (BOOL)containsString:(NSString*)string inString:(NSString*)longString;


//改变字体颜色大小，字符范围不一样
+ (NSAttributedString*)attributesWithString:(NSString *)allStr andChangeColorStr:(NSString *)changeColorStr andChangeFontStr:(NSString *)changeFontStr andColor:(UIColor *)color andFont:(UIFont *)font;


//判断字符串是否为空
//+(BOOL)isEmpty:(NSString*)text;
+(NSDate*)dateWithString:(NSString*)dateString andFomatter:(NSString*)fomatter;
@end

@interface HDSingletonLabel : UILabel

+ (HDSingletonLabel *)sharedInstance;

@end


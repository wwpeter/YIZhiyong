//
//  BITTextFieldProcess.m
//  Pods
//
//  Created       on 2018/8/2.
//  Copyright © 2017年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//


#import "BITTextFieldProcess.h"
#import "sys/utsname.h"
//#import "BITSingleObject.h"
#import "BGUICKeyChainStore.h"

@implementation BITTextFieldProcess

#pragma mark - 3 4 4分割的手机号输入功能函数
/*****************************************************************************
 函数:   (Boolean)checkTelFormat : (NSString *)string
 描述:   检查字符串是否为指定的格式
 调用:
 被调用: ((NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
 返回值: 是指定格式返回真，否则为假
 其它:   调用者保证字符串为空的情况，减少重复检查参数
 ******************************************************************************/
+ (Boolean)checkTelFormat : (NSString *)string
{
    char *tel_char = (char *)[string UTF8String];
    NSInteger i;
    i = strlen(tel_char);
    if(i >= 9)
    {
        if((tel_char[3] != ' ') || (tel_char[8] != ' '))
        {
            return NO;
        }
        
    }
    if(i >= 4)
    {
        if(tel_char[3] != ' ')
        {
            return NO;
        }
        
    }
    
    if(i == 3)
    {
        return NO;
    }
    else if(i == 8)
    {
        return NO;
    }
    
    return YES;
    
}


/*****************************************************************************
 函数:   (NSString *)getCorrectTelStr : (NSString *)string
 描述:   字符串格式化处理
 调用:
 被调用: ((NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
 返回值:
 其它:   调用者保证字符串为空的情况，减少重复检查参数
 ******************************************************************************/
+ (NSString *)getCorrectTelStr : (NSString *)string
{
    //多一个字符位为了保证能放下增加空格的字符串
    NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", string, @"1"]];
    char *tel_char = (char *)[str UTF8String];
    //    char *newTel_char = (char *)[string UTF8String];
    //    char tel_char[12] = {0};
    char newTel_char[14] = {0};
    char c;
    NSInteger i, j, len;
    memset(newTel_char, 0, strlen(newTel_char));
    len = strlen(tel_char);
    
    j = 0;
    for(i = 0; i < len - 1; i++)
    {
        c = tel_char[i];
        if(c != ' ')
        {
            newTel_char[j++] = c;
        }
        
    }
    
    memset(tel_char, 0, len);
    j = 0;
    for(i = 0; i < strlen(newTel_char); i++)
    {
        c = newTel_char[i];
        tel_char[j++] = c;
        
        if((i == 2) || (i == 6))
        {
            tel_char[j++] = ' ';
        }
    }
    
    
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
    
}

/*****************************************************************************
 函数:   (NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
 描述:   字符串拼接，判断字符串是否为指定格式，字符串格式化
 调用:   (Boolean)checkTelFormat1 : (NSString *)string,
 (NSString *)getCorrectTelStr : (NSString *)string
 被调用: (BOOL)textField:(UITextField *)textField
 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 返回值:
 其它:
 ******************************************************************************/
+ (NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
{
    char *tel_char = (char *)[string UTF8String];
    char *textFieldValue_char = (char *)[textFieldValue UTF8String];
    NSString *resultStr = nil;
    NSInteger len1, len2;
    len1 = strlen(textFieldValue_char);
    len2 = strlen(tel_char);
    if((len1 == 0) && (len2 == 1))
    {
        return string;
    }
    if((len1 == 1) && (len2 == 0))
    {
        return @"";
    }
    else if((textFieldValue_char[len1 - 1] == ' ') && (tel_char[len2 - 1] != ' ') && (len1 > len2) && (len1 != len2 + 2))
    {
        tel_char[len2 - 1] = '\0';
        return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
    }
    
    
    if(string.length == 0)
    {
        return @"";
    }
    
    if([self checkTelFormat:string])
    {
        return string;
    }
    
    
    resultStr = [self getCorrectTelStr:string];
    return resultStr;
    
}

/*****************************************************************************
 函数:   (NSString *)getNewStr : (NSString *)string : (NSString *)textFieldValue : (NSInteger)index
 描述:   中间增加字符处理
 调用:
 被调用: (BOOL)textField:(UITextField *)textField
 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 返回值:
 其它:
 ******************************************************************************/
+ (NSString *)getNewStr : (NSString *)string : (NSString *)textFieldValue : (NSInteger)index
{
    if((string.length == 0) || (textFieldValue.length == 0) || (index < 0) || (index > [textFieldValue length]))
    {
        return nil;
    }
    
    
    char c;
    NSInteger i, j;
    NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", textFieldValue, @"1"]];
    char *tel_char = (char *)[str UTF8String];
    char *new_char = (char *)[string UTF8String];
    char *textFieldValue_char = (char *)[textFieldValue UTF8String];
    NSInteger len1, len2;
    len1 = strlen(textFieldValue_char);
    len2 = strlen(tel_char);
    if((len1 == 0) && (len2 == 0))
    {
        return string;
    }
    
    memset(tel_char, 0, len2);
    
    j = 0;
    for(i = 0; i < len1; i++)
    {
        if(i == index)
        {
            tel_char[j++] = new_char[0];
        }
        c = textFieldValue_char[i];
        tel_char[j++] = c;
    }
    
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
}

/*****************************************************************************
 函数:   (BOOL)checkNewStrLength : (NSString *)string : (NSString *)textFieldValue
 描述:   检查复制的字符串和文本种的字符串拼接在一起的字符串已经超过了最大手机号长度字符串13
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/
+ (BOOL)checkNewStrLength : (NSString *)string : (NSString *)textFieldValue
{
    long i, j, m, n;
    m = [string length];
    if(m > 13)
    {
        return NO;
    }
    
    n =[textFieldValue length];
    if(m + n > 13)
    {
        return NO;
    }
    j = 0;
    char *tel_char = (char *)[string UTF8String];
    for(i = 0; i < m; i++)
    {
        if(tel_char[i] == ' ')
        {
            j++;
        }
    }
    
    if(j > 2)
    {
        return NO;
    }
    
    
    if(n > 0)
    {
        char *textFieldValue_char = (char *)[textFieldValue UTF8String];
        for(i = 0; i < n; i++)
        {
            if(textFieldValue_char[i] == ' ')
            {
                j++;
            }
        }
        
        if(j > 2)
        {
            return NO;
        }
        else if(m + (2 - j) + n > 13)
        {
            return NO;
        }
        
    }
    
    
    return YES;
}



+ (BOOL)inputTelephone : (UITextField *)textField : (NSRange)range : (NSString *)string
{
    if((string.length == 1)&& (range.length == 0))
    {
        if(textField.text.length <= 1)
        {
            return YES;
        }
        else if((textField.text.length >= 4) && (textField.text.length <= 6) &&  (range.location >= 4) && (range.location <= 6))
        {
            return YES;
        }
        else if((textField.text.length >= 9) && (textField.text.length <= 12) &&  (range.location >= 9) && (range.location <= 11))
        {
            return YES;
        }
    }
    else if((string.length == 0)&& (range.length == 1))
    {
        if(textField.text.length <= 2)
        {
            return YES;
        }
        else if((textField.text.length >= 5) && (textField.text.length <= 7) &&  (range.location >= 4) && (range.location <= 6))
        {
            return YES;
        }
        else if((textField.text.length >= 10) && (textField.text.length <= 13) &&  (range.location >= 9) && (range.location <= 12))
        {
            return YES;
        }
        
    }
    
    //文本内容的长度限制
    if((range.location > 12) || (([textField.text length] >= 13) && (![string isEqualToString:@""])))
    {
        
        return NO;
    }
    
    else
    {
        //限制粘贴成的字符串超过手机号的长度
        if ((string != nil) && (![string isEqualToString:@""]))
        {
            if(![self checkNewStrLength:string :textField.text])
            {
                return NO;
            }
        }
        
        NSString *newStr = @"";
        if(![string isEqualToString:@""])  //增加字符操作时
        {
            //判断是否是在尾部增加
            if([textField.text length] == range.location)
            {
                //判断是否是输入的第一个字符
                if(textField.text != nil)
                {
                    //组装非格式的字符串
                    newStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", textField.text, string]];
                }
                else
                {
                    newStr = string;
                }
            }
            else
            {
                //中间增加字符处理
                newStr = [self getNewStr:string:textField.text:(range.location)];
                if(newStr.length == 0)
                {
                    return NO;
                }
                
            }
            
        }
        else //删除字符操作时
        {
            NSUInteger len = [textField.text length];
            //当只有一个字符，采用系统文本框删除处理
            if(len == 1)
            {
                return YES;
            }
            char *tel_char = (char *)[textField.text UTF8String];
            char *textFieldValue_char = (char *)[textField.text UTF8String];
            NSInteger i, j, k;
            memset(tel_char, 0, len);
            j = 0;
            k = range.location;
            //当是删除空格时连带删除前面的字符
            if(k == 3)
            {
                textFieldValue_char[3] = '\0';
                textFieldValue_char[2] = '\0';
            }
            else if(k == 8)
            {
                textFieldValue_char[8] = '\0';
                textFieldValue_char[7] = '\0';
            }
            //删除对应的字符，并生成新的非格式化的字符串
            for(i = 0; i < len; i++)
            {
                if((i != k) && (textFieldValue_char[i] != '\0'))
                {
                    tel_char[j++] = textFieldValue_char[i];
                }
            }
            
            newStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
        }
        
        //字符串格式化
        string = [self getTextFieldStr : newStr : textField.text];
        textField.text = string;
        //            NSLog("text value string: %@", string);
        return NO;
    }
}

@end


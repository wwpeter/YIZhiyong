//
//  NSString+Hash.m
//
//  Created by Tom Corwine on 5/30/12.
//

#import "NSString+Hash.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
//#import "DataSigner.h"
//#import "Base64Data.h"
//#import "SecKeyWrapper.h"
@implementation NSString (Hash)

- (NSString *)md5String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_MD5_DIGEST_LENGTH];
	CC_MD5(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String
{
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
	CC_SHA512(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key
{
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
	return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key
{
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
	return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key
{
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
	return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

#pragma mark - Helpers

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(NSInteger)length
{
	NSMutableString *mutableString = @"".mutableCopy;
	for (int i = 0; i < length; i++)
		[mutableString appendFormat:@"%02x", bytes[i]];
	return [NSString stringWithString:mutableString];
}


#pragma mark MoneyMoreMore
//公钥加密
//+ (NSString *)encryptWithString:(NSString *)content
//{
//    NSData *publicKey = [NSData dataFromBase64String:PartnerPublicKey];
//    NSData *usernamm = [content dataUsingEncoding: NSUTF8StringEncoding];
//    NSData *newKey= [SecKeyWrapper encrypt:usernamm publicKey:publicKey];
//    NSString *result = [newKey base64EncodedString];
//    return result;
//    
//}
//私钥签名
//+ (NSString*)doRsa:(NSString*)string
//{
//    id<DataSigner> signer;
//    signer = CreateRSADataSigner(PartnerPrivKey);
//    NSString *signedString = [signer signString:string];
//    return signedString;
//}
@end

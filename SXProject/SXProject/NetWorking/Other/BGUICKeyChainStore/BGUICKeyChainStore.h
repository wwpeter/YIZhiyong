//
//  BGUICKeyChainStore.h
//  BGUICKeyChainStore
//
//  Created by Kishikawa Katsumi on 11/11/20.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "BITNSObject.h"

#if !__has_feature(nullability)
#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define nullable
#define nonnull
#define null_unspecified
#define null_resettable
#define __nullable
#define __nonnull
#define __null_unspecified
#endif

#if __has_extension(objc_generics)
#define UIC_KEY_TYPE <NSString *>
#define UIC_CREDENTIAL_TYPE <NSDictionary <NSString *, NSString *>*>
#else
#define UIC_KEY_TYPE
#define UIC_CREDENTIAL_TYPE
#endif

NS_ASSUME_NONNULL_BEGIN

extern NSString * const BGUICKeyChainStoreErrorDomain;

typedef NS_ENUM(NSInteger, BGUICKeyChainStoreErrorCode) {
    BGUICKeyChainStoreErrorInvalidArguments = 1,
};

typedef NS_ENUM(NSInteger, BGUICKeyChainStoreItemClass) {
    BGUICKeyChainStoreItemClassGenericPassword = 1,
    BGUICKeyChainStoreItemClassInternetPassword,
};

typedef NS_ENUM(NSInteger, BGUICKeyChainStoreProtocolType) {
    BGUICKeyChainStoreProtocolTypeFTP = 1,
    BGUICKeyChainStoreProtocolTypeFTPAccount,
    BGUICKeyChainStoreProtocolTypeHTTP,
    BGUICKeyChainStoreProtocolTypeIRC,
    BGUICKeyChainStoreProtocolTypeNNTP,
    BGUICKeyChainStoreProtocolTypePOP3,
    BGUICKeyChainStoreProtocolTypeSMTP,
    BGUICKeyChainStoreProtocolTypeSOCKS,
    BGUICKeyChainStoreProtocolTypeIMAP,
    BGUICKeyChainStoreProtocolTypeLDAP,
    BGUICKeyChainStoreProtocolTypeAppleTalk,
    BGUICKeyChainStoreProtocolTypeAFP,
    BGUICKeyChainStoreProtocolTypeTelnet,
    BGUICKeyChainStoreProtocolTypeSSH,
    BGUICKeyChainStoreProtocolTypeFTPS,
    BGUICKeyChainStoreProtocolTypeHTTPS,
    BGUICKeyChainStoreProtocolTypeHTTPProxy,
    BGUICKeyChainStoreProtocolTypeHTTPSProxy,
    BGUICKeyChainStoreProtocolTypeFTPProxy,
    BGUICKeyChainStoreProtocolTypeSMB,
    BGUICKeyChainStoreProtocolTypeRTSP,
    BGUICKeyChainStoreProtocolTypeRTSPProxy,
    BGUICKeyChainStoreProtocolTypeDAAP,
    BGUICKeyChainStoreProtocolTypeEPPC,
    BGUICKeyChainStoreProtocolTypeNNTPS,
    BGUICKeyChainStoreProtocolTypeLDAPS,
    BGUICKeyChainStoreProtocolTypeTelnetS,
    BGUICKeyChainStoreProtocolTypeIRCS,
    BGUICKeyChainStoreProtocolTypePOP3S,
};

typedef NS_ENUM(NSInteger, BGUICKeyChainStoreAuthenticationType) {
    BGUICKeyChainStoreAuthenticationTypeNTLM = 1,
    BGUICKeyChainStoreAuthenticationTypeMSN,
    BGUICKeyChainStoreAuthenticationTypeDPA,
    BGUICKeyChainStoreAuthenticationTypeRPA,
    BGUICKeyChainStoreAuthenticationTypeHTTPBasic,
    BGUICKeyChainStoreAuthenticationTypeHTTPDigest,
    BGUICKeyChainStoreAuthenticationTypeHTMLForm,
    BGUICKeyChainStoreAuthenticationTypeDefault,
};

typedef NS_ENUM(NSInteger, BGUICKeyChainStoreAccessibility) {
    BGUICKeyChainStoreAccessibilityWhenUnlocked = 1,
    BGUICKeyChainStoreAccessibilityAfterFirstUnlock,
    BGUICKeyChainStoreAccessibilityAlways,
    BGUICKeyChainStoreAccessibilityWhenPasscodeSetThisDeviceOnly
    __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0),
    BGUICKeyChainStoreAccessibilityWhenUnlockedThisDeviceOnly,
    BGUICKeyChainStoreAccessibilityAfterFirstUnlockThisDeviceOnly,
    BGUICKeyChainStoreAccessibilityAlwaysThisDeviceOnly,
}
__OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_4_0);

typedef NS_ENUM(unsigned long, BGUICKeyChainStoreAuthenticationPolicy) {
    BGUICKeyChainStoreAuthenticationPolicyUserPresence        = 1 << 0,
    BGUICKeyChainStoreAuthenticationPolicyTouchIDAny          NS_ENUM_AVAILABLE(10_12_1, 9_0) = 1u << 1,
    BGUICKeyChainStoreAuthenticationPolicyTouchIDCurrentSet   NS_ENUM_AVAILABLE(10_12_1, 9_0) = 1u << 3,
    BGUICKeyChainStoreAuthenticationPolicyDevicePasscode      NS_ENUM_AVAILABLE(10_11, 9_0) = 1u << 4,
    BGUICKeyChainStoreAuthenticationPolicyControlOr           NS_ENUM_AVAILABLE(10_12_1, 9_0) = 1u << 14,
    BGUICKeyChainStoreAuthenticationPolicyControlAnd          NS_ENUM_AVAILABLE(10_12_1, 9_0) = 1u << 15,
    BGUICKeyChainStoreAuthenticationPolicyPrivateKeyUsage     NS_ENUM_AVAILABLE(10_12_1, 9_0) = 1u << 30,
    BGUICKeyChainStoreAuthenticationPolicyApplicationPassword NS_ENUM_AVAILABLE(10_12_1, 9_0) = 1u << 31,
}__OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);

@interface BGUICKeyChainStore : NSObject

@property (nonatomic, readonly) BGUICKeyChainStoreItemClass itemClass;

@property (nonatomic, readonly, nullable) NSString *service;
@property (nonatomic, readonly, nullable) NSString *accessGroup;

@property (nonatomic, readonly, nullable) NSURL *server;
@property (nonatomic, readonly) BGUICKeyChainStoreProtocolType protocolType;
@property (nonatomic, readonly) BGUICKeyChainStoreAuthenticationType authenticationType;

@property (nonatomic) BGUICKeyChainStoreAccessibility accessibility;
@property (nonatomic, readonly) BGUICKeyChainStoreAuthenticationPolicy authenticationPolicy
__OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
@property (nonatomic) BOOL useAuthenticationUI;

@property (nonatomic) BOOL synchronizable;

@property (nonatomic, strong, nullable) NSString *authenticationPrompt
__OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0);

@property (nonatomic, readonly, nullable) NSArray UIC_KEY_TYPE *allKeys;
@property (nonatomic, readonly, nullable) NSArray *allItems;

+ (NSString *)defaultService;
+ (void)setDefaultService:(NSString *)defaultService;

+ (BGUICKeyChainStore *)keyChainStore;
+ (BGUICKeyChainStore *)keyChainStoreWithService:(nullable NSString *)service;
+ (BGUICKeyChainStore *)keyChainStoreWithService:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;

+ (BGUICKeyChainStore *)keyChainStoreWithServer:(NSURL *)server protocolType:(BGUICKeyChainStoreProtocolType)protocolType;
+ (BGUICKeyChainStore *)keyChainStoreWithServer:(NSURL *)server protocolType:(BGUICKeyChainStoreProtocolType)protocolType authenticationType:(BGUICKeyChainStoreAuthenticationType)authenticationType;

- (instancetype)init;
- (instancetype)initWithService:(nullable NSString *)service;
- (instancetype)initWithService:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;

- (instancetype)initWithServer:(NSURL *)server protocolType:(BGUICKeyChainStoreProtocolType)protocolType;
- (instancetype)initWithServer:(NSURL *)server protocolType:(BGUICKeyChainStoreProtocolType)protocolType authenticationType:(BGUICKeyChainStoreAuthenticationType)authenticationType;

+ (nullable NSString *)bgStringForKey:(NSString *)key;
+ (nullable NSString *)bgStringForKey:(NSString *)key service:(nullable NSString *)service;
+ (nullable NSString *)bgStringForKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;

+ (nullable NSData *)bgDataForKey:(NSString *)key;
+ (nullable NSData *)bgDataForKey:(NSString *)key service:(nullable NSString *)service;
+ (nullable NSData *)bgDataForKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;

- (BOOL)contains:(nullable NSString *)key;

- (BOOL)bgSetString:(nullable NSString *)string forKey:(nullable NSString *)key;
- (BOOL)bgSetString:(nullable NSString *)string forKey:(nullable NSString *)key label:(nullable NSString *)label comment:(nullable NSString *)comment;
- (nullable NSString *)bgStringForKey:(NSString *)key;

- (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key;
- (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key label:(nullable NSString *)label comment:(nullable NSString *)comment;
- (nullable NSData *)bgDataForKey:(NSString *)key;

+ (BOOL)bgRemoveItemForKey:(NSString *)key;
+ (BOOL)bgRemoveItemForKey:(NSString *)key service:(nullable NSString *)service;
+ (BOOL)bgRemoveItemForKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;

+ (BOOL)removeAllItems;
+ (BOOL)bgRemoveAllItemsForService:(nullable NSString *)service;
+ (BOOL)bgRemoveAllItemsForService:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup;

- (BOOL)bgRemoveItemForKey:(NSString *)key;

- (BOOL)removeAllItems;

- (nullable NSString *)objectForKeyedSubscript:(NSString<NSCopying> *)key;
- (void)setObject:(nullable NSString *)obj forKeyedSubscript:(NSString<NSCopying> *)key;

+ (nullable NSArray UIC_KEY_TYPE *)allKeysWithItemClass:(BGUICKeyChainStoreItemClass)itemClass;
- (nullable NSArray UIC_KEY_TYPE *)allKeys;

+ (nullable NSArray *)allItemsWithItemClass:(BGUICKeyChainStoreItemClass)itemClass;
- (nullable NSArray *)allItems;

- (void)setAccessibility:(BGUICKeyChainStoreAccessibility)accessibility authenticationPolicy:(BGUICKeyChainStoreAuthenticationPolicy)authenticationPolicy
__OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);

#if TARGET_OS_IOS
- (void)sharedPasswordWithCompletion:(nullable void (^)(NSString * __nullable account, NSString * __nullable password, NSError * __nullable error))completion;
- (void)sharedPasswordForAccount:(NSString *)account completion:(nullable void (^)(NSString * __nullable password, NSError * __nullable error))completion;

- (void)setSharedPassword:(nullable NSString *)password forAccount:(NSString *)account completion:(nullable void (^)(NSError * __nullable error))completion;
- (void)removeSharedPasswordForAccount:(NSString *)account completion:(nullable void (^)(NSError * __nullable error))completion;

+ (void)requestSharedWebCredentialWithCompletion:(nullable void (^)(NSArray UIC_CREDENTIAL_TYPE *credentials, NSError * __nullable error))completion;
+ (void)requestSharedWebCredentialForDomain:(nullable NSString *)domain account:(nullable NSString *)account completion:(nullable void (^)(NSArray UIC_CREDENTIAL_TYPE *credentials, NSError * __nullable error))completion;

+ (NSString *)generatePassword;
#endif

@end

@interface BGUICKeyChainStore (ErrorHandling)

+ (nullable NSString *)bgStringForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (nullable NSString *)bgStringForKey:(NSString *)key service:(nullable NSString *)service error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (nullable NSString *)bgStringForKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (nullable NSData *)bgDataForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (nullable NSData *)bgDataForKey:(NSString *)key service:(nullable NSString *)service error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (nullable NSData *)bgDataForKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup error:(NSError * __nullable __autoreleasing * __nullable)error;

- (BOOL)bgSetString:(nullable NSString *)string forKey:(NSString * )key error:(NSError * __nullable __autoreleasing * __nullable)error;
- (BOOL)bgSetString:(nullable NSString *)string forKey:(NSString * )key label:(nullable NSString *)label comment:(nullable NSString *)comment error:(NSError * __nullable __autoreleasing * __nullable)error;

- (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
- (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key label:(nullable NSString *)label comment:(nullable NSString *)comment error:(NSError * __nullable __autoreleasing * __nullable)error;

- (nullable NSString *)bgStringForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
- (nullable NSData *)bgDataForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgRemoveItemForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgRemoveItemForKey:(NSString *)key service:(nullable NSString *)service error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgRemoveItemForKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgRemoveAllItemsWithError:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgRemoveAllItemsForService:(nullable NSString *)service error:(NSError * __nullable __autoreleasing * __nullable)error;
+ (BOOL)bgRemoveAllItemsForService:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup error:(NSError * __nullable __autoreleasing * __nullable)error;

- (BOOL)bgRemoveItemForKey:(NSString *)key error:(NSError * __nullable __autoreleasing * __nullable)error;
- (BOOL)bgRemoveAllItemsWithError:(NSError * __nullable __autoreleasing * __nullable)error;

@end

@interface BGUICKeyChainStore (ForwardCompatibility)

+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service genericAttribute:(nullable id)genericAttribute;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup genericAttribute:(nullable id)genericAttribute;
+ (BOOL)bgSetString:(nullable NSString *)value forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service genericAttribute:(nullable id)genericAttribute;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup genericAttribute:(nullable id)genericAttribute;
+ (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key service:(nullable NSString *)service accessGroup:(nullable NSString *)accessGroup genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

- (BOOL)bgSetString:(nullable NSString *)string forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute;
- (BOOL)bgSetString:(nullable NSString *)string forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

- (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute;
- (BOOL)bgSetData:(nullable NSData *)data forKey:(NSString *)key genericAttribute:(nullable id)genericAttribute error:(NSError * __nullable __autoreleasing * __nullable)error;

@end

@interface BGUICKeyChainStore (Deprecation)

- (void)synchronize __attribute__((deprecated("calling this method is no longer required")));
- (BOOL)synchronizeWithError:(NSError * __nullable __autoreleasing * __nullable)error __attribute__((deprecated("calling this method is no longer required")));

@end

NS_ASSUME_NONNULL_END

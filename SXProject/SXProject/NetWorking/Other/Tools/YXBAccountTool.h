//
//  YXBAccountTool.h
//  haohuitui
//
//  Created by huihui on 2022/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBAccountTool : NSObject
//@property (nonatomic, strong)  NSArray *topModelArr;
@property (nonatomic, assign)  NSInteger topModelArrIndex;//首页
@property (nonatomic, assign)  NSInteger topModelArrIndexFast;//急速
@property (nonatomic, assign)  NSInteger topModelArrIndexCenterAndBottom;
//@property (nonatomic, strong)  NSString *topModelArrIndexCenterAndBottom;//腰部底部


+(YXBAccountTool *) sharedAccountTool;
//token失效
-(void)tokenOut;

- (void)removeAccount;
//回tabbar页面
-(void)goSelectTabbar:(NSUInteger )index;
//注册协议
-(void)goUserAgreementH5;
//隐私协议
-(void)goPrivacyAgreementH5;
//个人-平台信息授权书
-(void)goShareAgreementH5;
//个人-机构信息授权书
-(void)goPersonAgreementH5BoothId:(NSString *)boothId;
//贷款知情书
-(void)goKnowAgreementH5:(NSString *)title;
@end

NS_ASSUME_NONNULL_END

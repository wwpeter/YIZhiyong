//
//  NetworkRequestManager.m
//  SXProject
//
//  Created by 王威 on 2024/4/22.
//

#import "NetworkRequestManager.h"
#import "RequestSetAPI.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SXProject-Swift.h>
#import <SXBaseModule/NSString+SXin.h>

@interface NetworkRequestManager()

@end

@implementation NetworkRequestManager

+ (instancetype)sharedInstance {
    static NetworkRequestManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化操作
    }
    return self;
}


- (void)requestPath:(NSString *)netPath withParam:(NSDictionary *)param Success:(SuccessBlockT)success
            Failure:(FailureBlock)failure {
    //请求的配置
    RequestSetAPI *api = [[RequestSetAPI alloc] init];
    [api setParam:param];
    BITRequestApi *requestAPI = [api getRequesApi:netPath];
    
//    SX(weakSelf);
    [[BITRequestClient sharedClient] loadDataWithApi:requestAPI successBlock:^(NSString * _Nullable result) {
        
        NSDictionary *dic = result.mj_JSONObject;
        NSDictionary *tempDic = dic;
        if ([tempDic isKindOfClass:[NSDictionary class]] || [tempDic isKindOfClass:[NSArray class]] || [tempDic isKindOfClass:[NSNull class]]) {
            
            if (tempDic != [NSNull null]) {
                NSString *jsonStr = tempDic.mj_JSONString;
                if (success){
                    success(jsonStr);
                }
            } else {
                if (success){
                    NSDictionary *dic = @{@"code":@"-1"};
                    NSString *tempStr = [dic mj_JSONString];
                    success(tempStr);
                }
            }
        } else {
            if (success){
                NSDictionary *dic = @{@"code":result};
                NSString *tempStr = [dic mj_JSONString];
                success(tempStr);
            }
        }
    } failureBlock:^(NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)showError:(NSString *)msg {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setImageViewSize:CGSizeMake(0, 0)];
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD dismissWithDelay:1.0];
}

- (void)uploadDataPath:(NSString *)netPath withData:(NSData *)imageData imageName:(NSString *)imageName Success:(SuccessBlockT)success
               Failure:(FailureBlock)failure {
    //请求的配置
    RequestSetAPI *api = [[RequestSetAPI alloc] init];
//    [api setParam:param];
    BITRequestApi *requestAPI = [api getRequesApi:netPath];
    
//    SX(weakSelf);
    [[BITRequestClient sharedClient] uploadTaskWithApi:requestAPI constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nullable formData) {
//        UIImage *img = [[UIImage alloc] initWithData:imageData];
//        NSData *imageData = UIImageJPEGRepresentation(img, 0.8);
        [formData appendPartWithFileData:imageData name:imageName fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/jpeg"];
    } successBlock:^(NSString * _Nullable result) {
        NSDictionary *dic = result.mj_JSONObject;
        NSDictionary *tempDic = dic[@"data"];
//        NSString *serialNo = dic[@"serialNo"];
        if (tempDic != [NSNull null]) {
            NSString *jsonStr = tempDic.mj_JSONString;
            if (success){
                success(jsonStr);
            }
        } else {
            if (success){
                success(@"");
            }
        }
//        if ([netPath containsString:@"queryWifiConfigRecord"]) {
//            [SVProgressHUD showErrorWithStatus:serialNo];
//        }
    } failureBlock:^(NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end


/*
 SUCCESS("0000", "成功"),
 EXCEPTION("9999","系统异常"),
 PARAM_VALIDATE_ERROR("9998","参数校验错误"),
 SIGN_FAIL("9997", "验签失败"),
 VALIDATE_CODE_ERROR("9996", "验证码错误或者已过期"),
 VALIDATE_CODE_SEND("9995", "验证码已发送"),
 REQUEST_BODY_FAIL("9996", "参数不能为空"),
 VALIDATE_CODE_SEND_ERROR("9997", "验证码发送失败"),

 BG_PASSWORD_ERROR("BG_00001", "登录失败请检查账号密码"),
 BG_USER_FREEZE("BG_00002", "账号已被冻结"),
 BG_LOGIN_EXPIRED("BG_00003", "登录失效，请重新登录"),
 BG_AUTH_NOT_ENOUGH("BG_00004", "权限不足"),
 BG_AUTH_FAIL("BG_00005", "鉴权失败"),
 BG_ROLE_NOT_EXITS("BG_00006", "角色不存在"),
 BG_ROLE_HAS_USER("BG_00007", "角色下有用户存在"),
 BG_ROLE_NAME_REPEAT("BG_00008", "角色名称重复"),
 BG_USER_MOBILE_REPEAT("BG_00009", "用户手机号重复"),
 BG_USER_NOT_EXIST("BG_00010", "用户不存在"),
 BG_USER_PASSWORD_EXPIRE("BG_00011", "用户密码过期，请重置密码"),
 BG_USER_PASSWORD_SANE("BG_00012", "新密码不能和原来的密码一致"),
 BG_USER_EMAIL_REPEAT("BG_00013", "用户邮箱重复"),

 APP_PARAM_VALIDATE_ERROR("APP_9998", "参数校验错误"),
 APP_VALIDATE_CODE_ERROR("APP_9997", "验证码错误或者已过期"),
 APP_PASSWORD_NOT_SAME("APP_9996", "密码不一致"),
 APP_PASSWORD_FORMAT_ERROR("APP_9995", "密码格式"),
 APP_PASSWORD_ERROR("APP_9994", "密码错误"),

 APP_USER_NOT_EXIST("APP_00004", "用户不存在"),
 APP_USER_EXIST("APP_00005", "用户已存在"),

 APP_DEVICE_NOT_EXIST("20001", "设备不存在"),
 APP_DEVICE_NAME_REPEAT("20002", "设备名称重复"),
 APP_DEVICE_NOT_ONLINE("20003", "设备不在线"),
 APP_DEVICE_NOT_OFFLINE("20004", "设备不离线"),
 APP_DEVICE_NOT_SHARE("20005", "设备未分享"),
 APP_DEVICE_SHARE_REPEAT("20006", "设备已分享"),
 APP_DEVICE_SHARE_NOT_EXIST("20007", "分享设备不存在"),
 APP_DEVICE_SHARE_NOT_SELF("20008", "不能分享给自己"),
 APP_DEVICE_SHARE_NOT_EXIST_SELF("20009", "分享设备不存在"),
 APP_DEVICE_SHARE_NOT_EXIST_OTHER("20010", "分享设备不存在"),
 APP_DEVICE_SHARE_NOT_SELF_OR_OTHER("20011", "不能分享给自己或者分享设备不存在"),
 APP_SEND_CREATE_MAP_CMD_ERROR("20012", "发送创建地图命令失败"),
 APP_CREATE_MAP_COUNT_ERROR("20013", "最多可保存4张地图"),
 APP_SEND_CLEAN_CMD_ERROR("20014", "发送配置失败"),
 APP_CARPET_CLEAN_ERROR("20015", "地毯配置参数错误"),
 APP_CLEAN_ERROR("20016", "清洁配置参数错误"),
 APP_DEVICE_EXIST_OR_BIND("20017", "设备已存在或被其他用户绑定"),
 APP_DEVICE_NO_PERMIT_SHARE("20018", "无权限分享设备"),
 APP_SEND_IOT_CMD_ERROR("20019", "iot命令发送失败"),
 */

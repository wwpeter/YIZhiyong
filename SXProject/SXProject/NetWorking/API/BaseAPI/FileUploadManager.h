//
//  FileUploadManager.h
//  SXProject
//
//  Created by 王威 on 2024/5/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKey.h>

NS_ASSUME_NONNULL_BEGIN


@interface FileUploadManager : NSObject

//单例类创建方法
+ (instancetype)shareManager;

-(void)cancleAllTask;

/// 上传图片
/// - Parameters:
///   - path: 上传地址
///   - data: 上传数据 img
///   - param: 上传body参数
- (void)fileUpload:(NSString *)path data:(UIImage *)img param:(NSDictionary *)param callback:(void(^)(id obj, NSError *error))callback;

///  上传图片
/// - Parameters:
///   - url: 上传地址
///   - params: 参数
///   - imageArr: 图片数组
///   - callback: 回调
- (void)postImg:(NSString *)url
         params:(id)params
       imageArr:(NSMutableArray *)imageArr
       callback:(void(^)(id obj, NSError *error))callback;

/**
 文件上传功能，先调用这个授权接口，然后再调用接口返回数据里的host作为文件上传接口文件上传接口参数为：
 OSSAccessKeyId：accessIdsignature：signaturepolicy：policykey：dir+key+文件后缀file：要上传的文件上传成功后，
 http的code为204，body为空上传成功后自己拼接图片地址：fileUrlPrefix+dir+key+文件后缀名
 
 - Parameters:
 - path: 上传地址
 - data: 上传数据
 - param: 上传参数
 - callback: 回调
 */

- (void)fileVideoUpload:(NSString *)path dataURL:(NSURL *)url param:(NSDictionary *)param callback:(void(^)(id obj, NSError *error))callback;

/// 上次多个视频
/// - Parameters:
///   - path: 上传地址
///   - dataArr: 上传数据
///   - param:  上传参数
///   - callback: 回调
- (void)fileVideosUpload:(NSString *)path datas:(NSMutableArray *)dataArr param:(NSDictionary *)param callback:(void(^)(id obj, NSError *error))callback;


@end

NS_ASSUME_NONNULL_END

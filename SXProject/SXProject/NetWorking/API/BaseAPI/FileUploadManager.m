//
//  FileUploadManager.m
//  SXProject
//
//  Created by 王威 on 2024/5/17.
//

#import "FileUploadManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface FileUploadManager()
@property (nonatomic, strong) AFHTTPSessionManager     *sessionManager;
@end

@implementation FileUploadManager

#pragma mark - 创建单例方法
+ (instancetype)shareManager
{
    static FileUploadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FileUploadManager alloc]init];
    });
    return manager;
}

#pragma mark - 取消所有网络请求
-(void)cancleAllTask
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

- (void)fileUpload:(NSString *)path data:(UIImage *)img param:(NSDictionary *)param callback:(void(^)(id obj, NSError *error))callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *URLString = path; // 替换为实际的上传地址
    NSDictionary *parameters = param; // 根据需要传递的其他参数
 
    [manager POST:URLString
        parameters:parameters
         headers:nil
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:@"header.jpg"
                                mimeType:@"image/jpeg"];
    }
    progress:nil
    success:^(NSURLSessionDataTask *task, id responseObject) {
        // 上传成功的处理逻辑
        NSLog(@"Upload success: %@", responseObject);
        callback(@{@"code":@"200"}, nil);
    }
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 上传失败的处理逻辑
        NSLog(@"Upload failure: %@", error);
        callback(nil, error);
    }];
}

- (void)postImg:(NSString *)url
         params:(id)params
       imageArr:(NSMutableArray *)imageArr
       callback:(void(^)(id obj, NSError *error))callback {
    //选择需要的解析格式
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
   
    [manager POST:url
        parameters:params
         headers:nil
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //遍历图片数组
        for (UIImage *image in imageArr) {
            // 图片太大会上传不到服务器上面去
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            /*
             此方法参数
             1. 要上传的[二进制数据]
             2. 对应后台处理文件的[字段"files"]（根据后台定义的字段名来）
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg"];
        }
    }
    progress:nil
    success:^(NSURLSessionDataTask *task, id responseObject) {
        // 上传成功的处理逻辑
        NSLog(@"Upload success: %@", responseObject);
        callback(responseObject, nil);
    }
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 上传失败的处理逻辑
        NSLog(@"Upload failure: %@", error);
        callback(nil, error);
    }];
}
- (void)fileVideoUpload:(NSString *)path dataURL:(NSURL *)url param:(NSDictionary *)param callback:(void(^)(id obj, NSError *error))callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *URLString = path; // 替换为实际的上传地址
    NSDictionary *parameters = param; // 根据需要传递的其他参数
 
    // 构建要上传的视频文件的 URL
    NSURL *videoURL = url;
    
    [manager POST:URLString
        parameters:parameters
         headers:nil
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:videoURL name:@"video" fileName:@"video.mp4" mimeType:@"video/mp4" error:nil];
        [formData appendPartWithFileURL:videoURL name:@"file" error:nil];
    }
    progress:nil
    success:^(NSURLSessionDataTask *task, id responseObject) {
        // 上传成功的处理逻辑
        NSLog(@"Upload success: %@", responseObject);
        callback(@{@"code":@"200"}, nil);
    }
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 上传失败的处理逻辑
        NSLog(@"Upload failure: %@", error);
        callback(nil, error);
    }];
   
}

/// 上次多个视频
/// - Parameters:
///   - path: 上传地址
///   - dataArr: 上传数据
///   - param:  上传参数
///   - callback: 回调
- (void)fileVideosUpload:(NSString *)path datas:(NSMutableArray *)dataArr param:(NSDictionary *)param callback:(void(^)(id obj, NSError *error))callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *URLString = path; // 替换为实际的上传地址
    NSDictionary *parameters = param; // 根据需要传递的其他参数
 
    // 构建要上传的视频文件的 URL
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"video" withExtension:@"mp4"];
    // 构建要上传的视频组文件的 URL 数组
    NSArray<NSURL *> *videoURLs = @[videoURL, videoURL, videoURL]; // 替换为您的视频组文件的 URL 数组
    
    [manager POST:URLString
        parameters:parameters
         headers:nil
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSURL *videoURL in videoURLs) {
                NSString *fileName = [videoURL lastPathComponent];
            NSString *mimeType = @"";//[self mimeTypeForFileURL:videoURL];
                [formData appendPartWithFileURL:videoURL name:@"videos" fileName:fileName mimeType:mimeType error:nil];
            }
        [formData appendPartWithFileURL:videoURL name:@"video" fileName:@"video.mp4" mimeType:@"video/mp4" error:nil];
    }
    progress:nil
    success:^(NSURLSessionDataTask *task, id responseObject) {
        // 上传成功的处理逻辑
        NSLog(@"Upload success: %@", responseObject);
        callback(@{@"code":@"200"}, nil);
    }
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 上传失败的处理逻辑
        NSLog(@"Upload failure: %@", error);
        callback(nil, error);
    }];
}

// 获取文件的 MIME 类型
//- (NSString *)mimeTypeForFileURL:(NSURL *)fileURL {
//    NSString *pathExtension = [fileURL pathExtension];
//    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)pathExtension, NULL);
//    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
//    CFRelease(UTI);
//    if (mimeType) {
//        return (__bridge_transfer NSString *)mimeType;
//    }
//    return @"application/octet-stream";
//}
@end

//
//  TFNetworkTools.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFNetworkTools.h"
#import "TFHTTPSessionManager.h"
#import <AFNetworking.h>

@implementation TFNetworkTools
#pragma mark -------  GET 请求数据
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    TFHTTPSessionManager *manger = [TFHTTPSessionManager manager];
    
    [[TFHTTPSessionManager manager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [manger GET:Common_Interface_Montage(url) parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end

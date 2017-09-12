//
//  XYHttpTool.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYHttpTool.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *manager = nil;

@implementation XYHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure
{
    // 1.创建管理者
    manager = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 成功调用成功block
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 失败调用失败block
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建管理者
    manager = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        
        for (XYFormData* formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建管理者
    manager = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)cancelAllTasks
{
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}



@end


/**
 *  用来封装文件数据的模型
 */
@implementation XYFormData

@end

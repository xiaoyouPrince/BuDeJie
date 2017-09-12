//
//  XYHttpTool.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//
//  通用的网络请求工具类

#import <Foundation/Foundation.h>

@interface XYHttpTool : NSObject

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(NSArray *)formDataArray success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end


/**
 *  用来封装文件数据的模型
 */
@interface XYFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end

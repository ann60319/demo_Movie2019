//
//  MovieDataManager.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/21.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "MovieDataManager.h"
#import "Protocol.h"
#import "URLConst.h"
#import "AFHTTPSessionManager.h"

@implementation MovieDataManager




+ (id)sharedDataManager {
    static MovieDataManager *sharedDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

-(void)getMovieData:(int)page
       success:(void (^)(NSDictionary *dic))success
       failure:(void (^)(NSError *error))failure{
    
    NSString *m_url = URLPREFIX;
    NSString* fullURL = [m_url stringByAppendingString:[NSString stringWithFormat:@"%d", page]];
    
    NSLog(@"get data been called fullURL: %@",fullURL);
    
    //after called get query plz add on 1 for page
    [self getQuery:nil failure:failure success:success fullURL:fullURL];
    
}


- (void)getQuery:(NSDictionary *)input
         failure:(void (^)(NSError *))failure
         success:(void (^)(NSDictionary *))success
           fullURL:(NSString *)urlString {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30.f;
    configuration.timeoutIntervalForResource = 30.f;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:input];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    [manager GET:urlString parameters:parameters progress:nil
     
         success:^(NSURLSessionDataTask *operation, id responseObject) {
             
             NSDictionary *p_dic = responseObject;
             
             if (p_dic !=nil) {
                 if (success) {
                     success(p_dic);
                 }
             }else if (failure) {
                 NSError *error =
                 [NSError errorWithDomain:@"org.link.travel"
                                     code:200
                                 userInfo:responseObject];
                 failure(error);
             }
         }
         failure:^(NSURLSessionDataTask *operation, NSError *error) {
             LogMethodArgs(@"%@", [error localizedDescription]);
             if (failure) {
                 failure(error);
             }
         }];
}

@end

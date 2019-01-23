//
//  Protocol.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/21.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#ifndef Protocol_h
#define Protocol_h


#endif /* Protocol_h */
@protocol MTableViewModelDelegate <NSObject>
- (void)dataDidLoad;
- (void)getDataFail:(NSError*)error;

@end

@protocol APIService<NSObject>
+ (id)sharedDataManager;
-(void)getMovieData:(int)page
            success:(void (^)(NSDictionary *dic))success
            failure:(void (^)(NSError *error))failure;
@end


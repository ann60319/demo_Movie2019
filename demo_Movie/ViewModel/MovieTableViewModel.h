//
//  MovieTableViewModel.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/21.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTableViewModel : NSObject

- (instancetype)initWithDelegate:(id<MTableViewModelDelegate>) delegate;
- (void) loadMore;
-(void)getMovieData:(int)page;

@property (nonatomic, weak) id<APIService> apiService;
@property(nonatomic, weak) id<MTableViewModelDelegate> viewModeldelegate;
@property (nonatomic, readonly) NSMutableArray *arrayMovies;
@property(atomic, assign) int allPages;
@property(atomic, assign) int page;
@end

NS_ASSUME_NONNULL_END

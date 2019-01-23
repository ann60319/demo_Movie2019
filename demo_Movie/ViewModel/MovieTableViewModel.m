//
//  MovieTableViewModel.m
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/21.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import "MovieTableViewModel.h"
#import "Protocol.h"
#import "Movie_Data.h"
#import "MovieDataManager.h"

@implementation MovieTableViewModel


-(instancetype)initWithDelegate:(id<MTableViewModelDelegate>)delegate{
    self = [super init];
    if (!self) return nil;
    _viewModeldelegate = delegate;
    _arrayMovies = NSMutableArray.new;
    _apiService = [MovieDataManager sharedDataManager];
    
    return self;
}

-(void)getMovieData:(int) page{
    __weak typeof(self) weakSelf = self;
    [self.apiService getMovieData:page
      success:^(NSDictionary *dic){
          [self parseData:dic];
      }
      failure:^(NSError *error){
          [weakSelf.viewModeldelegate getDataFail:error];
     }];
}

-(void)loadMore{
    if(self.page < self.allPages){
        self.page++;
        [self getMovieData:self.page];
    }
}

-(void)parseData:(NSDictionary *)input{
    NSNumber *allPages = input[@"total_pages"];
    self.allPages = allPages.intValue;
    NSNumber *page = input[@"page"];
    self.page = page.intValue;
    
    NSArray *results = [input valueForKey:@"results"];
    NSLog(@"result: %@",results);
    
    for(NSDictionary *result in results){
        
        Movie_Data *movie = Movie_Data.new;
        [movie initWithDict:result];
        [_arrayMovies addObject:movie];
        [self.viewModeldelegate dataDidLoad];

    }
}
@end

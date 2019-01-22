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
    
    return self;
}

-(void)loadMore{
    NSLog(@"load more.....");
}

-(void)parseData:(NSDictionary *)input{
    NSArray *all_Pages = [input valueForKey:@"total_pages"];
    self.allPages = [[NSString stringWithFormat:@"%@", all_Pages] intValue];
    
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

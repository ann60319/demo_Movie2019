//
//  URLConst.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/21.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LogMethodArgs(format, ...) NSLog(@"%s: %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:format, ## __VA_ARGS__]);

NS_ASSUME_NONNULL_BEGIN

static NSString *const URLPREFIX = @"https://api.themoviedb.org/3/discover/movie?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US&include_adult=false&include_video=false&page=";
static NSString *const URLIMAGE = @"https://image.tmdb.org/t/p/w200";
static NSString *const URLMOVIEHOMEPAGE = @"https://api.themoviedb.org/3/movie/";
static NSString *const APIKEY = @"?api_key=b97a81e1fcf56b0268751c485866beae&language=en-US";


@interface URLConst : NSObject

@end

NS_ASSUME_NONNULL_END

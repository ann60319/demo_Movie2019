//
//  Movie_Data.h
//  demo_Movie
//
//  Created by Yi Hwei Huang on 2019/1/22.
//  Copyright © 2019 Yi Hwei Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie_Data : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSString *homepage;
@property (strong, nonatomic) NSString *original_Language;
@property (strong, nonatomic) NSString *movie_Id;
@property (strong, nonatomic) NSString *poster_Path;
@property (strong, nonatomic) NSString *release_Date;

@property (strong,nonatomic) NSNumber *vote_Average;

@property (strong,nonatomic) NSMutableArray *arr_movies;
@property(nonatomic,strong) NSDictionary* dictionary;

-(void)initWithDict:(NSDictionary *) dictionary;
@end

NS_ASSUME_NONNULL_END
